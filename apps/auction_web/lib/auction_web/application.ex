defmodule AuctionWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      #The book had an issue caused by the initial structure of the umbrella app where the PubSub was not initiated. Supposed to be created when
      #using Ecto but we specifically not used it. I added the next line and fixed it.
      {Phoenix.PubSub, name: AuctionWeb.PubSub},
      AuctionWeb.Telemetry,
      # Start the Endpoint (http/https)
      AuctionWeb.Endpoint,

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AuctionWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AuctionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
