defmodule PaypalIpnForwarder.Manager do
  use GenServer

  defmodule State do
    defstruct sender_server: nil, server: nil, router: nil, client_simulator: nil
  end

  def start_link(opts \\ []) do
    state = %State{sender_server: PaypalIpnForwarder.SenderSimulator.start_link,
                   server: PaypalIpnForwarder.Server.start_link,
                   router: PaypalIpnForwarder.Router.start_link,
                   client_simulator: PaypalIpnForwarder.ClientSimulator.start_link
                  }
    GenServer.start_link(__MODULE__, :ok, [state])
  end

  def init(_) do
    {:ok, nil}
  end

end
