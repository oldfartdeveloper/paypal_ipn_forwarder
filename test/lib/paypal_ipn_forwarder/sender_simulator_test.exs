defmodule PaypalIpnForwarder.SenderSimulatorTest do
  use ExUnit.Case, async: true
  alias PaypalIpnForwarder.SenderSimulator
  alias PaypalIpnForwarder.Server

  setup do
    {:ok, simulator} = SenderSimulator.start_link
    {:ok, server} = Server.start_link
    {:ok, processes: {simulator, server} }
  end

  test "Holds server (almost an identify test)", %{processes: {simulator, server}} do
    SenderSimulator.set_server(simulator, server)
    actual = SenderSimulator.server(simulator)
    assert(actual === server)
  end

end
