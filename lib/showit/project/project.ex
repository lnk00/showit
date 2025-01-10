defmodule Showit.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :bucket_id, :string
    field :desc, :string
    field :name, :string
    belongs_to :user, Showit.Auth.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :bucket_id, :desc])
    |> validate_required([:name, :bucket_id, :desc])
  end
end
