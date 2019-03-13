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
    
  end
end
