defmodule Tasks2.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "time_blocks" do
    field :end, :date
    field :start, :date
    belongs_to :task, Tasks2.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(time_block, attrs) do
    time_block
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
