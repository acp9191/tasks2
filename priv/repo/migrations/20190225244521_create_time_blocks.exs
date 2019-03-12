defmodule Tasks2.Repo.Migrations.CreateTimeBlocks do
  use Ecto.Migration

  def change do
    create table(:time_blocks) do
      add :start, :date
      add :end, :date
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    # create index(:time_block, [:task_id])
  end
end
