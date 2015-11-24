# Everything needed to debug making an SSH acknowledgeyement request
# back to the PayPal sandbox to verify that the sandbox was the source of the
# IPN post just received.
defmodule PaypalIpnForwarder.Acknowledgement do

  @ssl_files_path "/Users/SSmith/work/hedgeye-cms/vendor/plugins/active_merchant/lib/certs"
  @cacert_file "#{@ssl_files_path}/cacert.pem"
  @cert_file ""
  @key_file ""
#  @ssl [cacertfile: @cacert_file, keyfile: @key_file, certfile: @cert_file]
  @ssl [cacertfile: @cacert_file]
  # The only argument is the raw data being sent for acknowledgement
  def ack(raw) do

    # Start out really clumsy: just do everything from beginning to end here:
    HTTPoison.start
    HTTPoison.post!(
      "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate",
      raw,
      %{
        "Content-Type" => "application/x-www-form-urlencoded",
        "User-Agent"   => "Active Merchant -- http://activemerchant.org"
      },
      ssl: @ssl
    )
  end

end
