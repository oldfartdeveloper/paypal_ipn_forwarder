Feature: Configure a reverse proxy
  As a developer
  I only want to capture Paypal IPNs when I'm specifically testing this functionality
  So that I don't cause the Paypal sandbox to constantly retry.

  # These are not implemented as test software; just creating them to get
  # my requirement thoughts down on paper.

  Background: Software is installed and Paypal sandbox configured
    Given that the Elixir software has been installed and is running on the server
    And that the Elixir software has been installed on the development computer
    And the Paypal sandbox IPN URL port has been set to the one identifying which development computer is using it.
  Scenario: When proxy operation is not running
    Given that the router has not registered with the server.
    When the Paypal sandbox sends an IPN to the server
    Then the server echos the IPN to the sandbox
    And the sandbox verifies that it was the transmitter of the IPN
    And the server discards the IPN information.

  Scenario: Turn on the Paypal proxy operation
    When I start the Elixir software on the development computer
    And I start a new instance of the server sofware on the public box
    And I register the development computer with the server software
      | Registration Port Number |                       3333 |
      | Developer's Email        | scottnelsonsmith@gmail.com |
    When the corresponding Paypal sandbox sends an IPN intended for this developer
    Then the server echos the IPN to the sandbox
    And the sandbox verifies that it was the transmitter of the IPN
    And the server pushes the IPN to the Elixir router software on the developer's laptop.
    And the router sends the IPN to the running CMS instance on the developer's laptop.
