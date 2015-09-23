defmodule PaypalIpnForwarder.SenderSimulator do
  use GenServer

  ## Client API

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def set_server(pid, server) do
    GenServer.cast(pid, {:set_server, server})
  end

  def server(pid) do
    GenServer.call(pid, :server)
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, nil}
  end

  def handle_cast({:set_server, server}, _server) do
    {:noreply, server}
  end

  def handle_call(:server, _from, state) do
    {:reply, state, state}
  end

end
