defmodule Tasks2.Repo.Migrations.CreateMentorships do
  use Ecto.Migration

  def change do
    create table(:mentorships) do
      add :manager_id, references(:users, on_delete: :nothing), null: false
      add :underling_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:mentorships, [:manager_id, :underling_id])
  end
end
