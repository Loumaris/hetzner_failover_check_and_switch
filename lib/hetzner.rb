####################################################################################################
# load ips from config and remove the current active ip
####################################################################################################
def get_unused_ip
  (SERVER_LIST - [get_current_used_ip]).first
end

####################################################################################################
# return current used ip
####################################################################################################
def get_current_used_ip
  api_response = get_api_call(API_URL + "/failover/" + FAILOVER_IP)
  current_server_ip = api_response["failover"]["server_ip"]

  current_server_ip
end

####################################################################################################
# propagate the new ip
####################################################################################################
def switch_to_ip(ip)
  post_api_call(API_URL + "/failover/" + FAILOVER_IP, {active_server_ip: ip})
end

####################################################################################################
# make an authenticated GET call
####################################################################################################
def get_api_call(url)
  result = RestClient::Request.new(
    url: url,
    method: :get,
    user: API_USER,
    password: API_PASSWORD,
  ).execute

  JSON.parse(result)
end

####################################################################################################
# make an authenticated POST call
####################################################################################################
def post_api_call(url, data)
  result = RestClient::Request.new(
    url: url,
    method: :get,
    user: API_USER,
    password: API_PASSWORD,
    data: data
  ).execute

  JSON.parse(result)
end

