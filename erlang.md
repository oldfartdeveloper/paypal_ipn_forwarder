# Erlang configuration

Here are the configuration details.

# Server Configuration

The server configuration is an AWS EC2 micro T2 instance.

## Port Access

It has the following ports open for incoming internet traffic:

| Port (range) | Purpose |
|---|---|
| 22 | ssh |
| 80 | http |
| 443 | https |
| 4369 | EPMD |
| 9100-9115 | Up to 16 Nodes |
