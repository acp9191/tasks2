defmodule Tasks2.Repo.Migrations.CreateTimeBlocks do
  use Ecto.Migration

  def change do
    create table(:time_blocks) do
      add :start, :utc_datetime
      add :end, :utc_datetime
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    # create index(:time_block, [:task_id])
  end
end
