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

  # def sender_simulator do
  #   GenServer.call()
  # end

  def init(_) do
    {:ok, sender_simulator} = PaypalIpnForwarder.SenderSimulator.start_link
    {:ok, server} = PaypalIpnForwarder.Server.start_link
    {:ok, router} = PaypalIpnForwarder.Router.start_link
    {:ok, client_simulator} = PaypalIpnForwarder.ClientSimulator.start_link
    PaypalIpnForwarder.SenderSimulator.set_server(sender_simulator, server)
    PaypalIpnForwarder.Server.set_servers(server, sender_simulator, router)
    PaypalIpnForwarder.Router.set_servers(router, server, client_simulator)

    state = %State{sender_server: sender_simulator,
                   server: server,
                   router: router,
                   client_simulator: client_simulator
                  }
    {:ok, state}
  end

  ####################
  # Helper Functions #
  ####################

end
