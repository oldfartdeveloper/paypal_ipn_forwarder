defmodule PaypalIpnForwarder.SenderSimulatorTest do
  use ExUnit.Case, async: true
  alias PaypalIpnForwarder.SenderSimulator
  alias PaypalIpnForwarder.Server

  setup do
    {:ok, simulator} = SenderSimulator.start_link
    {:ok, server} = Server.start_link
    {:ok, simulator: simulator, server: server }
  end

  test "Holds server", %{simulator: simulator, server: server} do
    SenderSimulator.set_server(simulator, server)
    assert(server == SenderSimulator.server(simulator))
  end

end
