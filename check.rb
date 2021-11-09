####################################################################################################
# start the check by loading all dependencies
####################################################################################################
require_relative "boot"
require_relative "lib/postgres.rb"
require_relative "lib/hetzner.rb"
require_relative "lib/utils.rb"
require_relative "lib/mail.rb"

####################################################################################################
# try to connect to the failover ip,
#   success: nothing happend
#   fail: check rescue ip and switch if possible and promote the standby to primary node
####################################################################################################
begin
  p "Connection successful for ip #{FAILOVER_IP}"

  connection = check_connection(FAILOVER_IP)
  reset_tracking_file! if connection
rescue PG::Error => e
  msg = "Connection failed to ip #{FAILOVER_IP} #{current_tracking_state}/#{CONNECTION_TRIES}"

  send_notification!("#{current_tracking_state}/#{CONNECTION_TRIES} connection fails for #{FAILOVER_IP}", msg)

  track_failed_connection!

  if current_tracking_state >= CONNECTION_TRIES
    msg = "switching to ip #{get_unused_ip} after #{CONNECTION_TRIES} failed connection attempts"
    p msg
    send_notification!("SWITCHING #{FAILOVER_IP} FROM #{get_current_used_ip} TO #{get_unused_ip}", msg)
    begin
      backup_ip = get_unused_ip
      resuce_connection = check_connection(backup_ip)
      switch_to_ip(backup_ip)
      touch_trigger_file(backup_ip)
    rescue
      send_notification!("SWITCHING FAILED", "Please check what's going wrong.")
    ensure
      resuce_connection.close if resuce_connection
    end
  end
ensure
  connection.close if connection
end
