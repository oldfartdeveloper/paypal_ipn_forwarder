defmodule PaypalIpnForwarder.Server do
  use GenServer
  alias PaypalIpnForwarder.SenderSimulator
  alias PaypalIpnForwarder.Router

  ## Client API

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def set_servers(pid, sender, router) do
    servers = %{} |> Dict.put(:sender, sender) |> Dict.put(:router, router)
    GenServer.cast(pid, {:set_servers, servers})
  end

  def sender_server(pid) do
    GenServer.call(pid, :sender_server)
  end

  def router(pid) do
    GenServer.call(pid, :router)
  end

  def notify(pid, notification) do
    GenServer.cast(pid, {:notify, notification})
  end

  ## Server Callbacks

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:set_servers, servers}, _state) do
    {:noreply, servers}
  end

  def handle_call(:sender_server, _from, state) do
    {:reply, state |> Dict.get(:sender), state}
  end

  def handle_call(:router, _from, state) do
    {:reply, state |> Dict.get(:router), state}
  end

  def handle_cast({:notify, notification},  state) do
    sender = state |> Dict.get(:sender)
    ack = SenderSimulator.acknowledge(sender, notification)
    case ack do
      "VERIFIED" ->
        router = state |> Dict.get(:router)
        Router.notify(router, notification)
        {:noreply, state}
      "INVALID" ->
        {:noreply, state}
      _ ->
        {:stop, "Acknowledge to sender failed", state}

    end
  end
end
