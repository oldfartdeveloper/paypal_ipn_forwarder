defmodule PaypalIpnForwarder.Router do
  use GenServer
  alias PaypalIpnForwarder.ClientSimulator

  ## Client API

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def set_servers(pid, server, client_simulator) do
    servers = %{} |> Dict.put(:server, server) |> Dict.put(:client_simulator, client_simulator)
    GenServer.cast(pid, {:set_servers, servers})
  end

  def server(pid) do
    GenServer.call(pid, :server)
  end

  def client_simulator(pid) do
    GenServer.call(pid, :client_simulator)
  end

  def notify(pid, notification) do
    GenServer.cast(pid, {:notify, notification})
  end

  ## Server Callbacks

  def init(_) do
    {:ok, nil}
  end

  def handle_call(:server, _from, state) do
    {:reply, state |> Dict.get(:server), state}
  end

  def handle_call(:client_simulator, _from, state) do
    {:reply, state |> Dict.get(:client_simulator), state}
  end

  def handle_cast({:set_servers, servers}, _state) do
    {:noreply, servers}
  end

  def handle_cast({:notify, notification}, state) do
    client = state |> Dict.get(:client_simulator)
    ClientSimulator.notify(client, notification)
    {:noreply, state}
  end
end
