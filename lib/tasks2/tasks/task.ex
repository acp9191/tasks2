defmodule Tasks2.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :description, :string
    field :is_completed, :boolean, default: false
    has_many :time_block, Tasks2.TimeBlocks.TimeBlock
    field :title, :string
    belongs_to :user, Tasks2.Users.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :is_completed, :user_id])
    |> validate_required([:title, :description, :is_completed, :user_id])
  end
end
