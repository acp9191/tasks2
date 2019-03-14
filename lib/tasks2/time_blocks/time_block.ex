defmodule Tasks2.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "time_blocks" do
    field :end, :utc_datetime
    field :start, :utc_datetime
    belongs_to :task, Tasks2.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(time_block, attrs) do

    time_block
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:start, :end, :task_id])
    |> validate_proper_duration(:start)
    
  end

  def validate_proper_duration(changeset, field, _options \\ []) do
    validate_change(changeset, field, fn _, start ->
      if (DateTime.diff(changeset.changes.end, start) < 0) do
        [end: "End must come after start"]
      else
        []
      end
    end)
  end
end
