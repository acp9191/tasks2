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
    |> validate_no_underlings(:is_manager)
  end

  def validate_no_underlings(changeset, field, _options \\ []) do
    validate_change(changeset, field, fn _, is_manager ->
      if (!is_manager) do
        [is_manager: "User cannot be demoted"]
      else
        []
      end
    end)
  end
end
