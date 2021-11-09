####################################################################################################
# read tracking state
####################################################################################################
def current_tracking_state
  reset_tracking_file! unless File.exists?(CONNECTION_TRACK_FILE)

  file = File.open(CONNECTION_TRACK_FILE)
  current_state = file.read.to_i
  file.close

  current_state
end

####################################################################################################
# reset tracking state
####################################################################################################
def reset_tracking_file!
  File.write(CONNECTION_TRACK_FILE, 1)
end

####################################################################################################
# track failed connection
####################################################################################################
def track_failed_connection!
  count = current_tracking_state
  count += 1
  File.write(CONNECTION_TRACK_FILE, count)
end
