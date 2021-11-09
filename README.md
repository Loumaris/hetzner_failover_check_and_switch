[![build docker image](https://github.com/Loumaris/hetzner_failover_check_and_switch/actions/workflows/docker.yml/badge.svg?branch=main)](https://github.com/Loumaris/hetzner_failover_check_and_switch/actions/workflows/docker.yml)

# hetzner failover switch

This is a simple monitoring script which can check periodically a postgreSQL connection on a
postgreSQL cluster hosted on hetzner with an failover ip.

## configuration

* copy `config.example.yaml` to `config.yaml` and set the configuration
* add an ssh key to `ssh/id_rsa` which can access the server to create a trigger file
* (optional) add ssl certificates to `ssl/client.crt`, `ssl/client.key` and `ssl/root.crt` if your
  postgreSQL cluster support ssl connection
* run `ruby check.rb` via cron