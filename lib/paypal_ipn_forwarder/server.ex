defmodule PaypalIpnForwarder.Server do
  use GenServer

  ## Client API

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def set_servers(pid, sender, router) do
    servers = %{} |> Dict.put(:sender, sender) |> Dict.put(:router, router)
    GenServer.cast(pid, {:set_servers, servers})
  end

  ## Server Callbacks

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:set_servers, servers}, _state) do
    {:noreply, servers}
  end
end
