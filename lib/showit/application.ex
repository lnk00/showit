defmodule Showit.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ShowitWeb.Telemetry,
      Showit.Repo,
      {DNSCluster, query: Application.get_env(:showit, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Showit.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Showit.Finch},
      # Start a worker by calling: Showit.Worker.start_link(arg)
      # {Showit.Worker, arg},
      # Start to serve requests, typically the last entry
      ShowitWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Showit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShowitWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
