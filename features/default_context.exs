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
#  use PaypalIpnForwarder.SenderSimulator
  when_ ~r/^I launch the (?<app_name>.*)$/, fn state, %{app_name: app_name} ->
    {:ok, state |> Dict.put(:app_name, app_name)}
  end

  then_ "everything is configured", fn state ->
    actual_app_name = state |> Dict.get(:app_name)
    assert actual_app_name == "PayPal IPN sender simulator"
    {:ok, :whatever}
  end
end
