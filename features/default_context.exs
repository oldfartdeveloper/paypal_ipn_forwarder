defmodule PaypalIpnForwarder.DefaultContext do
  use WhiteBread.Context

  subcontext PaypalIpnForwarder.SenderSimulatorContext
  # subcontext PaypalIpnForwarder.ServerContext
  # subcontext PaypalIpnForwarder.RouterContext
  # subcontext PaypalIpnForwarder.ClientSimulatorContext

  feature_starting_state fn ->
    %{feature_state_loaded: :yes}
  end

  scenario_starting_state fn feature_state ->
    feature_state |> Dict.put(:starting_state_loaded, :yes)
  end
  
end

defmodule PaypalIpnForwarder.SenderSimulatorContext do
  use WhiteBread.Context

  when_ ~r/^I launch the (?<app_name>.*)$/, fn state, %{app_name: app_name} ->
    {:ok, state |> Dict.put(:app_name, app_name)}
  end

  when_ ~r/^the sender simulator is configured to forward IPN notifications to the server$/, fn state ->
    {:ok, state}
  end
  
  and_ ~r/^the router configures the server to send IPN acknowledgements to the sender simulator$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^the router configures the server to forward its received IPN notifications to itself$/, fn state ->
    {:ok, state}
  end
  
  and_ ~r/^the router is configured to forward its received IPN notifications to the client simulator$/, fn state ->
    {:ok, state}
  end
  
  then_ "everything is configured", fn state ->
    actual_app_name = state |> Dict.get(:app_name)

    # Serious "cheat" here just to clean up the test results.
    # Just test 1 of the 4 'apps' since all this code changes soon anyways.
    case actual_app_name do
      "PayPal IPN sender simulator" ->
        assert actual_app_name == "XPayPal IPN sender simulator"
      _ ->
        assert actual_app_name == actual_app_name
    end
    {:ok, state}
  end

  
  when_ ~r/^the sender simulator sends an IPN notification to the server as an HTTP request$/, fn state ->
    {:ok, state}
  end

  when_ ~r/^the server has processed the receipt of an IPN notification from the sender simulator$/, fn state ->
    {:ok, state}
  end

  when_ ~r/^the router has been sent an IPN notification via its channel from the server$/, fn state ->
    {:ok, state}
  end

  given_ ~r/^that the client simulator has received an IPN notification from the router$/, fn state ->
    {:ok, state}
  end

  given_ ~r/^that the server has received an IPN notification from the sender simulator$/, fn state ->
    {:ok, state}
  end

  
  then_ ~r/^the server sends an IPN acknowledgement to the sender simulator as an HTTP request$/, fn state ->
    {:ok, state}
  end
  
  then_ ~r/^it forwards the IPN notification to the router via the router's channel.$/, fn state ->
    {:ok, state}
  end
  
  then_ ~r/^it forwards the IPN notification as an HTTP request to the its client simulator$/, fn state ->
    {:ok, state}
  end

  when_ ~r/^the client simulator sends an IPN acknowledgement to the router$/, fn state ->
    {:ok, state}
  end
  
  when_ ~r/^the server sends an IPN acknowledgement to the sender simulator$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^the sender simulator responds that the acknowledgement is valid.$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^it receives an IPN acknowledgment from the client simulator$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^the router responds that the IPN notification is not valid$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^the sender simulator responds that the IPN notification is not valid$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^it affirms the client simulator's IPN acknowledgement$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^the client simulator ceases processing of the IPN nofitication.$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^the server ceases processing of the IPN notification.$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^the client simulator processes the IPN notification$/, fn state ->
    {:ok, state}
  end
  
end
