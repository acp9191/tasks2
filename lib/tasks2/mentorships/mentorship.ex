defmodule Tasks2.Mentorships.Mentorship do
  use Ecto.Schema
  import Ecto.Changeset


  schema "mentorships" do
    field :manager_id, :id
    field :underling_id, :id

    timestamps()
  end

  @doc false
  def changeset(mentorship, attrs) do
    mentorship
    |> cast(attrs, [])
    |> validate_required([])
  end
end
