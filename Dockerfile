FROM erlang:18.1

# Install Elixir
RUN apt-get update \
    && apt-get install unzip \
    && rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/elixir-lang/elixir/releases/download/v1.1.1/Precompiled.zip && \
    mkdir -p /opt/elixir-1.1.1/ && \
    unzip Precompiled.zip -d /opt/elixir-1.1.1/ && \
    rm Precompiled.zip
ENV PATH $PATH:/opt/elixir-1.1.1/bin
RUN mix local.hex --force \
    && mix local.rebar --force

# Create application folder:
RUN mkdir -p /app
WORKDIR /app

# Install application dependencies:
COPY mix.exs /app/
COPY mix.lock /app/
RUN mix deps.get \
    && mix deps.compile

# Compile application for release:
COPY . /app
RUN mix compile

# Configuring the Paypal IPN Forwarder:
EXPOSE 443 4369 9100 9101 9102 9103 9104 9105 9106 9107 9108 9109 9110 9111 9112 9113 9114 9115
CMD "./server_iex"
