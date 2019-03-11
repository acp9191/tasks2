defmodule Tasks2Web.MentorshipController do
  use Tasks2Web, :controller

  alias Tasks2.Mentorships
  alias Tasks2.Mentorships.Mentorship

  def index(conn, _params) do
    mentorships = Mentorships.list_mentorships()
    render(conn, "index.html", mentorships: mentorships)
  end

  def new(conn, _params) do
    changeset = Mentorships.change_mentorship(%Mentorship{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"mentorship" => mentorship_params}) do
    case Mentorships.create_mentorship(mentorship_params) do
      {:ok, mentorship} ->
        conn
        |> put_flash(:info, "Mentorship created successfully.")
        |> redirect(to: Routes.mentorship_path(conn, :show, mentorship))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mentorship = Mentorships.get_mentorship!(id)
    render(conn, "show.html", mentorship: mentorship)
  end

  def edit(conn, %{"id" => id}) do
    mentorship = Mentorships.get_mentorship!(id)
    changeset = Mentorships.change_mentorship(mentorship)
    render(conn, "edit.html", mentorship: mentorship, changeset: changeset)
  end

  def update(conn, %{"id" => id, "mentorship" => mentorship_params}) do
    mentorship = Mentorships.get_mentorship!(id)

    case Mentorships.update_mentorship(mentorship, mentorship_params) do
      {:ok, mentorship} ->
        conn
        |> put_flash(:info, "Mentorship updated successfully.")
        |> redirect(to: Routes.mentorship_path(conn, :show, mentorship))

      {:error, %Ecto.Changeset{} = changeset} ->
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
