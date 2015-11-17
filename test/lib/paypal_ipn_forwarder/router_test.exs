defmodule PaypalIpnForwarder.RouterTest do
  use ExUnit.Case, async: true
  alias PaypalIpnForwarder.Server
  alias PaypalIpnForwarder.Router

  setup do
    {:ok, server} = Server.start_link
    {:ok, router} = Router.start_link
    {:ok, {server, router}}
  end

  test "Can connect with server", {server, router} do
    assert true
  end
end
