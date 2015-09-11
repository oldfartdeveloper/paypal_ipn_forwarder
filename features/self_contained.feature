Feature: Test Everything in Developer's Machine
  As a developer
  I want to use my development machine's full programming facilities
  to implement all components
  So that I don't have to implement code in remote machines
  and that most discovery can be made in my laptop
  all in order to speed development.

  There are three components:

  1.  The PayPal IPN sender simulator
  1.  The server
  1.  The router
  4.  The PayPal client simulator

  Background: Launch and configure everything
    Given that the components are launched and configured

  Scenario: Test IPN notification handshake between sendor simulator and the server
    When the sender simulator sends an IPN notification to the server as an HTTP request
    Then the server sends an IPN acknowledgement to the sender simulator as an HTTP request
    And the sender simulator responds that the acknowledgement is valid.

  Scenario: Test IPN notification from server to router
    When the server has processed the receipt of an IPN notification from the sender simulator
    Then it forwards the IPN notification to the router via the router's channel.

  Scenario: Test IPN notification from router to client simulator
    When the router has been sent an IPN notification via its channel from the server
    Then it forwards the IPN notification as an HTTP request to the its client simulator
    And it receives an IPN acknowledgment from the client simulator
    And it affirms the client simulator's IPN acknowledgement
    And the client simulator processes the IPN notification

  Scenario: Router rejects client simulator's IPN acknowledgement
    Given that the client simulator has received an IPN notification from the router
    When the client simulator sends an IPN acknowledgement to the router
    And the router responds that the IPN notification is not valid
    Then the client simulator ceases processing of the IPN nofitication.

  Scenario: Sender simulator rejects server's IPN acknowledgement
    Given that the server has received an IPN notification from the sender simulator
    When the server sends an IPN acknowledgement to the sender simulator
    And the sender simulator responds that the IPN notification is not valid
    Then the server ceases processing of the IPN notification.

