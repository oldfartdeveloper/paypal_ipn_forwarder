defmodule PaypalIpnForwarder.Server do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def init(_) do
    {:ok, nil}
  end

end
