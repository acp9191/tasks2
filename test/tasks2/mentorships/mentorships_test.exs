defmodule Tasks2.MentorshipsTest do
  use Tasks2.DataCase

  alias Tasks2.Mentorships

  describe "mentorships" do
    alias Tasks2.Mentorships.Mentorship

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def mentorship_fixture(attrs \\ %{}) do
      {:ok, mentorship} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mentorships.create_mentorship()

      mentorship
    end

    test "list_mentorships/0 returns all mentorships" do
      mentorship = mentorship_fixture()
      assert Mentorships.list_mentorships() == [mentorship]
    end

    test "get_mentorship!/1 returns the mentorship with given id" do
      mentorship = mentorship_fixture()
      assert Mentorships.get_mentorship!(mentorship.id) == mentorship
    end

    test "create_mentorship/1 with valid data creates a mentorship" do
      assert {:ok, %Mentorship{} = mentorship} = Mentorships.create_mentorship(@valid_attrs)
    end

    test "create_mentorship/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mentorships.create_mentorship(@invalid_attrs)
    end

    test "update_mentorship/2 with valid data updates the mentorship" do
      mentorship = mentorship_fixture()
      assert {:ok, %Mentorship{} = mentorship} = Mentorships.update_mentorship(mentorship, @update_attrs)
    end

    test "update_mentorship/2 with invalid data returns error changeset" do
      mentorship = mentorship_fixture()
      assert {:error, %Ecto.Changeset{}} = Mentorships.update_mentorship(mentorship, @invalid_attrs)
      assert mentorship == Mentorships.get_mentorship!(mentorship.id)
    end

    test "delete_mentorship/1 deletes the mentorship" do
      mentorship = mentorship_fixture()
      assert {:ok, %Mentorship{}} = Mentorships.delete_mentorship(mentorship)
      assert_raise Ecto.NoResultsError, fn -> Mentorships.get_mentorship!(mentorship.id) end
    end

    test "change_mentorship/1 returns a mentorship changeset" do
      mentorship = mentorship_fixture()
      assert %Ecto.Changeset{} = Mentorships.change_mentorship(mentorship)
    end
  end
end
