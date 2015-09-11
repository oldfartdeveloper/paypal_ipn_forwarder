defmodule PaypalIpnForwarder.SenderSimulator do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def init(:ok) do
    {:ok, nil}
  end
  
end
