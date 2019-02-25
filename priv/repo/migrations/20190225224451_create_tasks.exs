defmodule Tasks1.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :string
      add :assigned_to, :string
      add :length, :integer
      add :is_completed, :boolean, default: false, null: false

      timestamps()
    end

  end
end
