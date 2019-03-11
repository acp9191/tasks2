defmodule Tasks2.Mentorships do
  @moduledoc """
  The Mentorships context.
  """

  import Ecto.Query, warn: false
  alias Tasks2.Repo

  alias Tasks2.Mentorships.Mentorship

  @doc """
  Returns the list of mentorships.

  ## Examples

      iex> list_mentorships()
      [%Mentorship{}, ...]

  """
  def list_mentorships do
    Repo.all(Mentorship)
  end

  @doc """
  Gets a single mentorship.

  Raises `Ecto.NoResultsError` if the Mentorship does not exist.

  ## Examples

      iex> get_mentorship!(123)
      %Mentorship{}

      iex> get_mentorship!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mentorship!(id), do: Repo.get!(Mentorship, id)

  @doc """
  Creates a mentorship.

  ## Examples

      iex> create_mentorship(%{field: value})
      {:ok, %Mentorship{}}

      iex> create_mentorship(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mentorship(attrs \\ %{}) do
    %Mentorship{}
    |> Mentorship.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mentorship.

  ## Examples

      iex> update_mentorship(mentorship, %{field: new_value})
      {:ok, %Mentorship{}}

      iex> update_mentorship(mentorship, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mentorship(%Mentorship{} = mentorship, attrs) do
    mentorship
    |> Mentorship.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Mentorship.

  ## Examples

      iex> delete_mentorship(mentorship)
      {:ok, %Mentorship{}}

      iex> delete_mentorship(mentorship)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mentorship(%Mentorship{} = mentorship) do
    Repo.delete(mentorship)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mentorship changes.

  ## Examples

      iex> change_mentorship(mentorship)
      %Ecto.Changeset{source: %Mentorship{}}

  """
  def change_mentorship(%Mentorship{} = mentorship) do
    Mentorship.changeset(mentorship, %{})
  end
end
