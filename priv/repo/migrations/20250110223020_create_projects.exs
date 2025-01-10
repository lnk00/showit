defmodule Showit.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :bucket_id, :string
      add :desc, :string
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
