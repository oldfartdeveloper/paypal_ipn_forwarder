defmodule PaypalIpnForwarder.RouterTest do
  use ExUnit.Case, async: true
  alias PaypalIpnForwarder.Server
  alias PaypalIpnForwarder.Router

  setup do
    {:ok, server} = Server.start_link
    {:ok, router} = Router.start_link
    {:ok, processes: {server, router}}
  end


  test "Registered router can receive messages from server", %{processes: {server, router}} do
    :not_implemented
  end
end
