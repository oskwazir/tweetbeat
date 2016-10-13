defmodule TweetbeatFw do
  use Application
  #alias Nerves.InterimWiFi, as: WiFi
  alias Nerves.Networking
  alias Nerves.SSDPServer
  alias Nerves.Lib.UUID

  @interface :eth0

  # define SSDP service type that allows discovery from the cell tool,
  # so a node running this example can be found with `cell list`
  defp publish_node_via_ssdp(_iface) do
    usn = "uuid:" <> UUID.generate
    st = "urn:nerves-project-org:service:cell:1"
    #fields = ["x-node": (node |> to_string) ]
    {:ok, _} = SSDPServer.publish usn, st
  end

  @doc "Attempts to perform a DNS lookup to test connectivity."
  def test_dns(hostname \\ 'nerves-project.org') do
    :inet_res.gethostbyname(hostname)
  end

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    
    unless :os.type == {:unix, :darwin} do     # don't start networking unless we're on nerves
      {:ok, _} = Networking.setup @interface
    end
    #publish_node_via_ssdp(@interface)
    {:ok, self}
    # :os.cmd('modprobe mt7603e')

    # Define workers and child supervisors to be supervised
    children = [
      worker(TweetbeatLib.Worker, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TweetbeatFw.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # def network do
  #   wlan_config = Application.get_env(:tweetbeat_fw, :wlan0)
  #   WiFi.setup "wlan0", wlan_config
  # end
end
