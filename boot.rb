####################################################################################################
# load libs
####################################################################################################
require "rest-client"
require "yaml"
require "json"
require "pg"
require "fileutils"
require 'net/ssh'

####################################################################################################
# load config into constants
####################################################################################################
CONFIG = YAML.load_file("config.yaml")

API_URL = "https://robot-ws.your-server.de/"
API_USER = CONFIG["api"]["user"]
API_PASSWORD = CONFIG["api"]["password"]
FAILOVER_IP = CONFIG["failover_ip"]
DB_USER = CONFIG["database"]["user"]
DB_PASSWORD = CONFIG["database"]["password"]
DB_PORT = CONFIG["database"]["port"]
DB_NAME = CONFIG["database"]["name"]
SERVER_LIST = CONFIG["server"]
SSH_USER = CONFIG["ssh_user"]
NOTIFICATION_EMAILS = CONFIG["notification_mail_to"]
TRIGGER_FILE = CONFIG["database"]["trigger_file"]
CONNECTION_TRIES = 3
CONNECTION_TRACK_FILE = 'track/count.state'