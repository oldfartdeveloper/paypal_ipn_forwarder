defmodule PaypalIpnForwarder do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    IO.puts("PaypalIpnForwarder.start/2...")
    PaypalIpnForwarder.Supervisor.start_link
  end
end
