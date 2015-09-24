defmodule PaypalIpnForwarder.DefaultContext do
  use WhiteBread.Context

  subcontext PaypalIpnForwarder.ManagerContext
  subcontext PaypalIpnForwarder.SenderSimulatorContext
  # subcontext PaypalIpnForwarder.ServerContext
  # subcontext PaypalIpnForwarder.RouterContext
  # subcontext PaypalIpnForwarder.ClientSimulatorContext

  feature_starting_state fn ->
    %{feature_state_loaded: :yes}
  end

  scenario_starting_state fn feature_state ->
    feature_state |> Dict.put(:starting_state_loaded, :yes)
  end

end

defmodule PaypalIpnForwarder.ManagerContext do
  use WhiteBread.Context
  alias PaypalIpnForwarder.Manager
  alias PaypalIpnForwarder.SenderSimulator
  alias PaypalIpnForwarder.Server
  alias PaypalIpnForwarder.Router
  alias PaypalIpnForwarder.ClientSimulator

  given_ ~r/^the four servers are created and configured$/, fn state ->
    {:ok, manager} = Manager.start_link
    {:ok, state |> Dict.put(:manager, manager)}
  end

  then_ ~r/^the (?<client>.*) can see the (?<server>.*)$/, fn state, %{client: client, server: server} ->
    manager = state |> Dict.get(:manager)
    case client do
      "sender simulator" ->
        sender_server = Manager.sender_server(manager)
        assert(Manager.server(manager) == SenderSimulator.server(sender_server))
      "server" ->
        server = Manager.server(manager)
        assert(Manager.sender_server(manager) == Server.sender_server(server))
        assert(Manager.router(manager) == Server.router(server))
      "router" ->
        router = Manager.router(manager)
        assert(Manager.server(manager) == Router.server(router))
        assert(Manager.client_simulator(manager) == Router.client_simulator(router))
      "client simulator" ->
        client_simulator = Manager.client_simulator(manager)
        assert(Manager.router(manager) == ClientSimulator.router(client_simulator))
      _ ->
        flunk "Unknown client '#{client}' or server '#{server}'"
    end
    {:ok, state}
  end

end

defmodule PaypalIpnForwarder.SenderSimulatorContext do
  use WhiteBread.Context
  alias PaypalIpnForwarder.Manager
  alias PaypalIpnForwarder.SenderSimulator
  alias PaypalIpnForwarder.Server
  alias PaypalIpnForwarder.Router
  alias PaypalIpnForwarder.ClientSimulator

  when_ ~r/^the sender simulator sends (?<notification>.+) to the server$/, fn state, %{notification: notification} ->
    manager = state |> Dict.get(:manager)
    sender_simulator = Manager.sender_server(manager)
    SenderSimulator.notify(sender_simulator, notification)
    {:ok, state}
  end

  when_ ~r/^the server has processed the receipt of an IPN notification from the sender simulator$/, fn state ->
    {:ok, state}
  end

  when_ ~r/^the router has been sent an IPN notification via its channel from the server$/, fn state ->
    {:ok, state}
  end

  given_ ~r/^that the client simulator has received an IPN notification from the router$/, fn state ->
    {:ok, state}
  end

  given_ ~r/^that the server has received an IPN notification from the sender simulator$/, fn state ->
    {:ok, state}
  end


  then_ ~r/^the server sends an IPN acknowledgement to the sender simulator as an HTTP request$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^it forwards the IPN notification to the router via the router's channel.$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^it forwards the IPN notification as an HTTP request to the its client simulator$/, fn state ->
    {:ok, state}
  end

  when_ ~r/^the client simulator sends an IPN acknowledgement to the router$/, fn state ->
    {:ok, state}
  end

  when_ ~r/^the server sends an IPN acknowledgement to the sender simulator$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^the sender simulator responds that the acknowledgement is valid.$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^it receives an IPN acknowledgment from the client simulator$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^the router responds that the IPN notification is not valid$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^the sender simulator responds that the IPN notification is not valid$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^it affirms the client simulator's IPN acknowledgement$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^the client simulator ceases processing of the IPN nofitication.$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^the server ceases processing of the IPN notification.$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^the client simulator processes the IPN notification$/, fn state ->
    {:ok, state}
  end

end
