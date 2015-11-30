FROM erlang:18.1
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
