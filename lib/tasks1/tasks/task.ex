defmodule Tasks1.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    belongs_to :user, HuskyShop.Users.User
    field :description, :string
    field :is_completed, :boolean, default: false
    field :length, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :assigned_to, :length, :is_completed])
    |> validate_required([:title, :description, :assigned_to, :length, :is_completed])
  end
end
