# UNDER CONSTRUCTION!!!

*Nothing here is ready for prime-time yet.*

## A Proxy to Forward your PayPal Sandbox's IPN's to your Development Machine

**[What this app does](paypal_ipn_forwarder.wiki/Home.md)**

## Features

1.  This Sinatra app only needs to be set up once to handle multiple PayPal sandboxes
    and multiple development machines.
1.  PayPal IPNs received while the target development machine is unavailable are responded to with a success
    response by this app.  The resulting IPN record is not queued.

## Prerequisites

If you have these resources, then this project may be useful to you:

1. A publicly-facing server that can host this project's Sinatra gem. Both your PayPal sandbox and development
   computer must be able to perform HTTP requests against this server.

1. This server must have a Ruby 1.9 or later to run this project with, and must be able to accept
   gems (such as [Sinatra](https://github.com/sinatra/sinatra/#readme)).

## Installation

You will need the identifiers for your PayPal sandboxes and your corresponding
development computers as follows:

### PayPal Sandbox ID

For this, you can use the `Secure Merchant Id` located which can be found in the PayPal sandbox. In the
profile tab, it is the second item which is presented.

### Development ID

For this, the developer's email is used in order to deliver some notifications and identify the developer.

### Run Tests

*To Do*

### Configure the IPN address in your PayPal sandbox(es).

In each PayPal sandbox, configure the server's URL for PayPal to send the IPN messages to.

[PayPal's guide](https://cms.paypal.com/cms_content/CA/en_US/files/developer/IPNGuide.pdf) describes
how to do this in section 3 on page 23.

### Configure the Router Component on Each Development Computer

This consists of installing the *router* gem and creating two aliases
so that the developer does not have to find the id of the
Sandbox every time that they run the gem.

The aliases should be saved in a bash config file (or equivalent) using:

```bash
alias paypal_testing_on='ruby start_paypal sandbox_id developer_id'
alias paypal_testing_off='ruby stop_paypal sandbox)id developer_id'
```

where `sandbox_id` is the id of the sandbox that the developer will be using
and `developer_id` is the email of the developer.

#### Running the Router

To start the *router*:

     paypal_testing_on

To stop:

     stop

If you inadvertently `control-c` out of the terminal window, that will not stop the process.
In this case, in another terminal you can stop the *router* process by:

     paypal_testing_off

### Run on Your Server

*TODO*

### Start your Development computer's Router that talks with the server app

*TODO*

### Start your Development computer's server that talks w/ its PayPal sandbox

When you set up recurring payments on PayPal, PayPal will start sending IPN notifications to you whenever
it deems necessary. This will happen, among other activities, when it notifies you that it charged
a credit card or that someone issued a refund on the PayPal sandbox side.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
