defmodule PaypalIpnForwarder.ClientSimulator do
  use GenServer

  ## Client API

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def set_router(pid, router) do
    GenServer.cast(pid, {:set_router, router})
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, nil}
  end

  def handle_cast({:set_router, router}, _state) do
    {:noreply, router}
  end

end
