defmodule Showit.Project do
  alias Showit.Repo
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
    |> cast(attrs, [:name, :bucket_id, :desc, :user_id])
    |> validate_required([:name, :bucket_id, :desc, :user_id])
  end

  def insert_project(attrs) do
    %Showit.Project{} |> changeset(attrs) |> Repo.insert()
  end
end
