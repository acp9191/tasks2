defmodule Tasks1.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :description, :string
    field :is_completed, :boolean, default: false
    field :length, :integer
    field :title, :string
    belongs_to :user, Tasks1.Users.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :length, :is_completed, :user_id])
    |> validate_required([:title, :description, :length, :is_completed, :user_id])
  end
end
