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

  def sender_server(pid) do
    GenServer.call(pid, :sender_server)
  end

  def server(pid) do
    GenServer.call(pid, :server)
  end

  def router(pid) do
    GenServer.call(pid, :router)
  end

  def client_simulator(pid) do
    GenServer.call(pid, :client_simulator)
  end

  def init(_) do
    {:ok, sender_simulator} = PaypalIpnForwarder.SenderSimulator.start_link
    {:ok, server} = PaypalIpnForwarder.Server.start_link
    {:ok, router} = PaypalIpnForwarder.Router.start_link
    {:ok, client_simulator} = PaypalIpnForwarder.ClientSimulator.start_link
    PaypalIpnForwarder.SenderSimulator.set_server(sender_simulator, server)
    PaypalIpnForwarder.Server.set_servers(server, sender_simulator, router)
    PaypalIpnForwarder.Router.set_servers(router, server, client_simulator)
    PaypalIpnForwarder.ClientSimulator.set_router(client_simulator, router)

    state = %State{sender_server: sender_simulator,
                   server: server,
                   router: router,
                   client_simulator: client_simulator
                  }
    {:ok, state}
  end

  def handle_call(:sender_server, _from, state) do
    {:reply, state.sender_server, state}
  end

  def handle_call(:server, _from, state) do
    {:reply, state.server, state}
  end

  def handle_call(:router, _from, state) do
    {:reply, state.router, state}
  end

  def handle_call(:client_simulator, _from, state) do
    {:reply, state.client_simulator, state}
  end

  ####################
  # Helper Functions #
  ####################

end
