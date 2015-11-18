defmodule PaypalIpnForwarder.ServerWeb do
  use Plug.Router

  plug :match
  plug :dispatch

  # Where our Paypal IPN forwarder is sending to:
  # https://4.196.147.91:3333/payments/ipn
  post "/send_ipn" do

  end

  defp do_match("POST", ["send_ipn"]), do
    conn
    |> Plug.Conn.fetch_params
  end

end
