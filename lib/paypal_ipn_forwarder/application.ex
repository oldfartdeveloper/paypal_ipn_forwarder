defmodule PaypalIpnForwarder.Application do
  use Application
  alias PaypalIpnForwarder.Manager


  def start(_, _) do
    Manager.start_link
  end
end
