####################################################################################################
# open a postgres connection either with or without ssl
####################################################################################################
def check_connection(ip)
  if File.exists?("ssl/client.crt") &&
     File.exists?("ssl/client.key") &&
     File.exists?("ssl/root.crt")
    postgres_ssl_connection(ip)
  else
    postgres_plain_connection(ip)
  end
end

####################################################################################################
# use normal database connection
####################################################################################################
def postgres_plain_connection(ip)
  PG::Connection.new(
    host: ip,
    user: DB_USER,
    dbname: DB_NAME,
    port: DB_PORT,
    password: DB_PASSWORD,
    connect_timeout: "1",
  )
end

####################################################################################################
# use ssl connection to postgres
####################################################################################################
def postgres_ssl_connection(ip)
  FileUtils.chmod 0600, %w(ssl/client.crt ssl/client.key ssl/root.crt)

  PG::Connection.new(
    host: ip,
    user: DB_USER,
    dbname: DB_NAME,
    port: DB_PORT,
    password: DB_PASSWORD,
    sslmode: "require",
    sslcert: "ssl/client.crt",
    sslkey: "ssl/client.key",
    sslrootcert: "ssl/root.crt",
    connect_timeout: "1",
  )
end

####################################################################################################
# propagate replication to main server with touching the trigger file
####################################################################################################
def touch_trigger_file(host_ip)
  FileUtils.chmod 0600, %w(ssh/id_rsa)

  Net::SSH.start(
    host_ip,
    SSH_USER,
    host_key: "ssh-rsa",
    keys: ["ssh/id_rsa"],
    verify_host_key: :never,
  ) do |session|
    session.exec!("sudo touch #{TRIGGER_FILE} ")
  end
end
