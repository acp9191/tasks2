defmodule Tasks2Web.MentorshipControllerTest do
  use Tasks2Web.ConnCase

  alias Tasks2.Mentorships

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:mentorship) do
    {:ok, mentorship} = Mentorships.create_mentorship(@create_attrs)
    mentorship
  end

  describe "index" do
    test "lists all mentorships", %{conn: conn} do
      conn = get(conn, Routes.mentorship_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Mentorships"
    end
  end

  describe "new mentorship" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.mentorship_path(conn, :new))
      assert html_response(conn, 200) =~ "New Mentorship"
    end
  end

  describe "create mentorship" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.mentorship_path(conn, :create), mentorship: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.mentorship_path(conn, :show, id)

      conn = get(conn, Routes.mentorship_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Mentorship"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.mentorship_path(conn, :create), mentorship: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Mentorship"
    end
  end

  describe "edit mentorship" do
    setup [:create_mentorship]

    test "renders form for editing chosen mentorship", %{conn: conn, mentorship: mentorship} do
      conn = get(conn, Routes.mentorship_path(conn, :edit, mentorship))
      assert html_response(conn, 200) =~ "Edit Mentorship"
    end
  end

  describe "update mentorship" do
    setup [:create_mentorship]

    test "redirects when data is valid", %{conn: conn, mentorship: mentorship} do
      conn = put(conn, Routes.mentorship_path(conn, :update, mentorship), mentorship: @update_attrs)
      assert redirected_to(conn) == Routes.mentorship_path(conn, :show, mentorship)

      conn = get(conn, Routes.mentorship_path(conn, :show, mentorship))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, mentorship: mentorship} do
      conn = put(conn, Routes.mentorship_path(conn, :update, mentorship), mentorship: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Mentorship"
    end
  end

  describe "delete mentorship" do
    setup [:create_mentorship]

    test "deletes chosen mentorship", %{conn: conn, mentorship: mentorship} do
      conn = delete(conn, Routes.mentorship_path(conn, :delete, mentorship))
      assert redirected_to(conn) == Routes.mentorship_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.mentorship_path(conn, :show, mentorship))
      end
    end
  end

  defp create_mentorship(_) do
    mentorship = fixture(:mentorship)
    {:ok, mentorship: mentorship}
  end
end
