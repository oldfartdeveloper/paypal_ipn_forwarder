defmodule PaypalIpnForwarder.SenderSimulator do
  use GenServer
  alias PaypalIpnForwarder.Server

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

  def notify(pid, notification) do
    GenServer.cast(pid, {:notify, notification})
  end

  def acknowledge(pid, notification) do
    GenServer.call(pid, {:acknowledge, notification})
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

  def handle_cast({:notify, notification}, server) do
    Server.notify(server, notification)
    {:noreply, server}
  end

  def handle_call({:acknowledge, notification}, _from, state) do
    IO.puts("*** In sender simulator acknowledge, notification is #{notification}")
    {:reply, "VERIFIED", state}
  end

end
