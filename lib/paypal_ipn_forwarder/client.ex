defmodule PaypalIpnForwarder.Client do
  use GenServer

  ## Client API

  def start_link(name, _opts \\ []) do
    {:ok, agent} = Agent.start_link fn -> "" end
    GenServer.start_link(__MODULE__, agent, name: {:global, {:router, name}})
  end

  def message(pid, msg) do
    GenServer.cast(pid, {:message, msg})
  end

  def get_message(pid) do
    GenServer.call(pid, :get_message)
  end

  ## Server Callbacks

  def init(agent) do
    { :ok, agent }
  end

  def handle_cast({:message, msg}, agent) do
    Agent.update(agent, fn _ -> msg end)
    { :noreply, agent }
  end

  def handle_call(:get_message, _from, agent) do
    { :reply, Agent.get(agent, fn msg -> msg end), agent}
  end

end
