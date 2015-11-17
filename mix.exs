defmodule PaypalIpnForwarder.Mixfile do
  use Mix.Project

  def project do
    [app: :paypal_ipn_forwarder,
     name: "Paypal IPN Forwarder",
     description: """
     Manages a reverse proxy to enable your laptop to receive IPN messages
     sent from your PayPal sandbox.

     NOTE: NOT SECURE!  DO NOT USE THIS IN PRODUCTION!
     """,
     version: "0.0.1",
     elixir: "~> 1.1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:white_bread, "~> 2.1.1", only: :dev}
    ]
  end
end
