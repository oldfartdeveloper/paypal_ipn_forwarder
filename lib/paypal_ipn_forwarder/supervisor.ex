defmodule PaypalIpnForwarder.Supervisor do
  use Supervisor

  def start_link do
    IO.puts "PaypalIpnForwarder.Supervisor.start_link..."
    Supervisor.start_link(__MODULE__, :ok)
  end

  @manager_name :mgr

  def init(_) do
    children = [
      worker(PaypalIpnForwarder.Manager, [[name: @manager_name]])
    ]
    IO.puts "PaypalIpnForwarder.Supervisor.init for #{@manager_name}..."
    supervise(children, strategy: :one_for_one)
  end

end
