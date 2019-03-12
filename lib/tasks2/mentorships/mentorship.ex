defmodule Tasks2.Mentorships.Mentorship do
  use Ecto.Schema
  import Ecto.Changeset

  alias Tasks2.Users
  alias Tasks2.Mentorships


  schema "mentorships" do
    belongs_to :manager, Tasks2.Users.User 
    belongs_to :underling, Tasks2.Users.User

    timestamps()
  end

  @doc false
  def changeset(mentorship, attrs) do
    mentorship
    |> cast(attrs, [:manager_id, :underling_id])
    |> validate_required([:manager_id, :underling_id])
    |> unique_constraint(:underling_id, name: :mentorships_manager_id_underling_id_index)
    |> validate_different_ids(:manager_id)
    |> validate_noncyclical_mentorship(:manager_id)
    |> validate_manager(:manager_id)
    |> validate_underling(:underling_id)
  end

  def validate_noncyclical_mentorship(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, manager_id ->
      if Map.has_key?(changeset.changes, :underling_id) do
        mentorship = Mentorships.get_manager(manager_id)
        if (mentorship.manager_id == changeset.changes.underling_id) do
          [underling_id: "Manager cannot be underling"]
        else
          []
        end
      else 
        []
      end
    end)
  end

  def validate_different_ids(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, manager_id ->
      if Map.has_key?(changeset.changes, :underling_id) do
        if (manager_id == changeset.changes.underling_id) do
          [underling_id: "Cannot be own manager"]
        else
          []
        end
      else 
        []
      end
    end)
  end

  def validate_manager(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, manager_id ->
      user = Users.get_user!(manager_id)
      if (!user.is_manager) do
        [manager_id: "User is not a manager"]
      else
        []
      end
    end)
  end

  def validate_underling(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, underling_id ->
      mentorship = Mentorships.get_manager(underling_id)
      if (mentorship != nil) do
        [underling_id: "User already has a manager"]
      else
        []
      end
    end)
  end

end
