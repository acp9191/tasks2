defmodule Tasks2Web.MentorshipController do
  use Tasks2Web, :controller

  alias Tasks2.Mentorships
  alias Tasks2.Mentorships.Mentorship

  alias Tasks2.Users

  def index(conn, _params) do
    mentorships = Mentorships.list_mentorships()

    mentorships = Enum.map(mentorships, fn mentorship -> 
      %Mentorship{mentorship | underling: Users.get_user!(mentorship.underling_id).email}
    end)

    mentorships = Enum.map(mentorships, fn mentorship -> 
      %Mentorship{mentorship | manager: Users.get_user!(mentorship.manager_id).email}
    end)

    render(conn, "index.html", mentorships: mentorships)
  end

  def new(conn, _params) do
    changeset = Mentorships.change_mentorship(%Mentorship{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"mentorship" => mentorship_params}) do
    manager_email = mentorship_params["manager_id"]
    manager_user = Users.get_user_by_email(manager_email)

    underling_email = mentorship_params["underling_id"]
    underling_user = Users.get_user_by_email(underling_email)

    mentorship_params = if (manager_user != nil) do
      Map.put(mentorship_params, "manager_id", manager_user.id)
    else
      mentorship_params
    end

    mentorship_params = if (underling_user != nil) do
      Map.put(mentorship_params, "underling_id", underling_user.id)
    else
      mentorship_params
    end

    case Mentorships.create_mentorship(mentorship_params) do
      {:ok, mentorship} ->
        conn
        |> put_flash(:info, "Mentorship created successfully.")
        |> redirect(to: Routes.mentorship_path(conn, :show, mentorship))

      {:error, %Ecto.Changeset{} = changeset} ->

        changeset = if Map.has_key?(changeset.changes, :manager_id) do
          manager_user = Users.get_user(changeset.changes.manager_id)
          changes = changeset.changes
          changes = %{changes | manager_id: manager_user.email}
          %{changeset | changes: changes}
        else
          changes = changeset.changes
          changes = Map.put(changes, :manager_id, manager_email)
          %{changeset | changes: changes}
        end

        changeset = if Map.has_key?(changeset.changes, :underling_id) do
          underling_user = Users.get_user(changeset.changes.underling_id)
          changes = changeset.changes
          changes = %{changes | underling_id: underling_user.email}
          %{changeset | changes: changes}
        else
          changes = changeset.changes
          changes = Map.put(changes, :underling_id, underling_email)
          %{changeset | changes: changes}
        end

        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mentorship = Mentorships.get_mentorship!(id)

    mentorship = %Mentorship{mentorship | underling: Users.get_user!(mentorship.underling_id).email}
    mentorship = %Mentorship{mentorship | manager: Users.get_user!(mentorship.manager_id).email}

    render(conn, "show.html", mentorship: mentorship)
  end

  def edit(conn, %{"id" => id}) do
    mentorship = Mentorships.get_mentorship!(id)
    mentorship = %Mentorship{mentorship | underling_id: Users.get_user!(mentorship.underling_id).email}
    mentorship = %Mentorship{mentorship | manager_id: Users.get_user!(mentorship.manager_id).email}
    changeset = Mentorships.change_mentorship(mentorship)
    render(conn, "edit.html", mentorship: mentorship, changeset: changeset)
  end

  def update(conn, %{"id" => id, "mentorship" => mentorship_params}) do
    mentorship = Mentorships.get_mentorship!(id)

    manager_email = mentorship_params["manager_id"]
    manager_user = Users.get_user_by_email(manager_email)

    underling_email = mentorship_params["underling_id"]
    underling_user = Users.get_user_by_email(underling_email)

    mentorship_params = if (manager_user != nil) do
      Map.put(mentorship_params, "manager_id", manager_user.id)
    else
      mentorship_params
    end

    mentorship_params = if (underling_user != nil) do
      Map.put(mentorship_params, "underling_id", underling_user.id)
    else
      mentorship_params
    end

    case Mentorships.update_mentorship(mentorship, mentorship_params) do
      {:ok, mentorship} ->
        conn
        |> put_flash(:info, "Mentorship updated successfully.")
        |> redirect(to: Routes.mentorship_path(conn, :show, mentorship))

      {:error, %Ecto.Changeset{} = changeset} ->
        
        mentorship = %{mentorship | manager_id: manager_email}
        changeset = if Map.has_key?(changeset.changes, :manager_id) do
          manager_user = Users.get_user(changeset.changes.manager_id)
          changes = changeset.changes
          changes = %{changes | manager_id: manager_user.email}
          %{changeset | changes: changes}
        else
          changes = changeset.changes
          changes = Map.put(changes, :manager_id, manager_email)
          %{changeset | changes: changes}
        end

        mentorship = %{mentorship | underling_id: underling_email}
        changeset = if Map.has_key?(changeset.changes, :underling_id) do
          underling_user = Users.get_user(changeset.changes.underling_id)
          changes = changeset.changes
          changes = %{changes | underling_id: underling_user.email}
          %{changeset | changes: changes}
        else
          changes = changeset.changes
          changes = Map.put(changes, :underling_id, underling_email)
          %{changeset | changes: changes}
        end

        render(conn, "edit.html", mentorship: mentorship, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mentorship = Mentorships.get_mentorship!(id)
    {:ok, _mentorship} = Mentorships.delete_mentorship(mentorship)

    conn
    |> put_flash(:info, "Mentorship deleted successfully.")
    |> redirect(to: Routes.mentorship_path(conn, :index))
  end
end
