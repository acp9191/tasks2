defmodule Tasks2.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :is_manager, :boolean, default: false
    field :email, :string
    has_many :tasks, Tasks2.Tasks.Task
    has_many :mentorships, Tasks2.Mentorships.Mentorship

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :is_manager])
    |> validate_required([:email, :is_manager])
  end
end
