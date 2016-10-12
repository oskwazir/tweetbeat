defmodule TweetbeatLib.Worker do
    use GenServer

    def start_link do
        {:ok, _pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
    end

    #####
    # External API 
    ##

    def start_stream(topic) do
        GenServer.call __MODULE__, %{start_stream: topic}
    end

    #####
    # GenServer implementation
    ##

    def handle_call(%{start_stream: topic}, _from, _state) do
        stream = ExTwitter.stream_filter(track: topic) |>
            Stream.map(fn(x) -> x.text end) |>
            Stream.map(fn(x) -> IO.puts "#{x}\n---------------\n" end)
        Enum.to_list(stream)
        {:reply, %{}, %{} }
    end
end