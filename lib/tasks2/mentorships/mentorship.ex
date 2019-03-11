defmodule Tasks2.Mentorships.Mentorship do
  use Ecto.Schema
  import Ecto.Changeset


  schema "mentorships" do
    belongs_to :manager, Tasks2.Users.User 
    belongs_to :underling, Tasks2.Users.User

    timestamps()
  end

  @doc false
  def changeset(mentorship, attrs) do
    mentorship
    |> cast(attrs, [])
    |> validate_required([])
  end
end
