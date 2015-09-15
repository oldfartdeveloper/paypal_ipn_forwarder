defmodule PaypalIpnForwarder.Manager do
  use GenServer

  defmodule State do
    defstruct sender_server: nil, server: nil, router: nil, client_simulator: nil
  end

  ##############
  # Client API #
  ##############

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  ####################
  # Server Callbacks #
  ####################

  def init(_) do
    state = %State{sender_server: PaypalIpnForwarder.SenderSimulator.start_link,
                   server: PaypalIpnForwarder.Server.start_link,
                   router: PaypalIpnForwarder.Router.start_link,
                   client_simulator: PaypalIpnForwarder.ClientSimulator.start_link
                  }
    {:ok, state}
  end

  ####################
  # Helper Functions #
  ####################

end
