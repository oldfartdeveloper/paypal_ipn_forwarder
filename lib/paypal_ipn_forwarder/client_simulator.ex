defmodule PaypalIpnForwarder.ClientSimulator do
  use GenServer

  ## Client API

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def set_router(pid, router) do
    GenServer.cast(pid, {:set_router, router})
  end

  def router(pid) do
    GenServer.call(pid, :router)
  end

  def notify(pid, notification) do
    GenServer.cast(pid, {:notify, notification})
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, nil}
  end

  def handle_cast({:set_router, router}, _state) do
    {:noreply, router}
  end

  def handle_cast({:notify, notification}, state) do
    IO.puts("Received :notify message with '#{notification}'")
    {:noreply, state}
  end

  def handle_call(:router, _from, state) do
    {:reply, state, state}
  end

end
