# Everything needed to debug making an SSH acknowledgeyement request
# back to the PayPal sandbox to verify that the sandbox was the source of the
# IPN post just received.
defmodule PaypalIpnForwarder.Acknowledgement do

  @ack_url "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate"

  # The only argument is the raw data being sent for acknowledgement
  def ack(raw) do

    # Start out really clumsy: just do everything from beginning to end here:
    HTTPoison.start
    response = HTTPoison.post(
      @ack_url,
      raw,
      %{
        "Content-Type" => "application/x-www-form-urlencoded",
        "User-Agent"   => "Active Merchant -- http://activemerchant.org"
      },
      ssl: [cacertfile: "certs/cacert.pem"]
    )
    case response do
      {:ok, resp} -> resp.body
    end
  end

end
