defmodule Showit.Repo do
  use Ecto.Repo,
    otp_app: :showit,
    adapter: Ecto.Adapters.Postgres
end
