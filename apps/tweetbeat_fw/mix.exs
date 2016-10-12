defmodule TweetbeatFw.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :tweetbeat_fw,
     version: "0.0.1",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.1.4"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {TweetbeatFw, []},
     applications: [:logger, 
      :tweetbeat_lib, 
      :nerves_interim_wifi,
      :nerves_ntp,
      :ui]]
  end

  def deps do
    [{:nerves, "~> 0.3.0"},
     {:nerves_interim_wifi, "~> 0.1.0"},
     {:nerves_ntp, "~> 0.1.1"},
     {:tweetbeat_lib, in_umbrella: true},
     {:ui, in_umbrella: true}]
  end

  def system(target) do
    [{:"nerves_system_#{target}", ">= 0.0.0"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
