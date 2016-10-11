# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
#
# Use the following to pull variables from the command prompt 
# System.get_env("WIFI_PASSWORD")

use Mix.Config
config :nerves, :firmware,
   rootfs_additions: "rootfs-additions"

config :tweetbeat_fw, :wlan0,
       ssid: System.get_env("WIFI_SSID"),
       key_mgmt: :"WPA-PSK",
       psk: System.get_env("WIFI_PASSWORD")

config :nerves_ntp, :ntpd, "/usr/sbin/ntpd"

config :nerves_ntp, :servers, [
  "0.pool.ntp.org",
  "1.pool.ntp.org",
  "2.pool.ntp.org",
  "3.pool.ntp.org"
]

config :extwitter, :oauth, [
  consumer_key: System.get_env("CONSUMER_KEY"),
  consumer_secret: System.get_env("CONSUMER_SECRET"),
  access_token: System.get_env("ACCESS_TOKEN"),
  access_token_secret: System.get_env("ACCESS_TOKEN_SECRET")
]
# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"
