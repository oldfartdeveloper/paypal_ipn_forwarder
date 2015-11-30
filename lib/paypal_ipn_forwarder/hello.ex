# A simple GenServer for testing cross-node commands:
defmodule PaypalIpnForwarder.Hello do
  use GenServer

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def hello(server) do
    GenServer.call(server, {:hello})
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, self}
  end

  def handle_call({:hello}, _from, _opts) do
    IO.puts "Hello, World!"
    {:reply, "ok", "state"}
  end

end
