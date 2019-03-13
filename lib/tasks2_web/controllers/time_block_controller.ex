defmodule Tasks2Web.TimeBlockController do
  use Tasks2Web, :controller

  alias Tasks2.TimeBlocks
  alias Tasks2.TimeBlocks.TimeBlock

  action_fallback Tasks2Web.FallbackController

  def index(conn, %{"task_id" => task_id}) do
    time_block = TimeBlocks.get_blocks_by_task_id(task_id)
    IO.inspect(time_block)
    render(conn, "index.json", time_block: time_block)
  end

  def create(conn, %{"time_block" => time_block_params}) do
    start_time = %DateTime{
      year:       time_block_params["start_year"] ,
      month:      time_block_params["start_month"] ,
      day:        time_block_params["start_day"] ,
      hour:       time_block_params["start_hour"] ,
      minute:     time_block_params["start_minute"] ,
      second:     time_block_params["start_second"] ,
      time_zone:  "Etc/UTC",
      zone_abbr:  "EST",
      utc_offset: 0,
      std_offset: 0
    }

    end_time = %DateTime{
      year:       time_block_params["end_year"] ,
      month:      time_block_params["end_month"] ,
      day:        time_block_params["end_day"] ,
      hour:       time_block_params["end_hour"] ,
      minute:     time_block_params["end_minute"] ,
      second:     time_block_params["end_second"] ,
      time_zone:  "Etc/UTC",
      zone_abbr:  "EST",
      utc_offset: 0,
      std_offset: 0
    }

    time_block_params = %{"start" => start_time, "end" => end_time, "task_id" => time_block_params["task_id"]}

    with {:ok, %TimeBlock{} = time_block} <- TimeBlocks.create_time_block(time_block_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.time_block_path(conn, :show, time_block))
      |> render("show.json", time_block: time_block)
    end
  end

  def show(conn, %{"id" => id}) do
    time_block = TimeBlocks.get_time_block!(id)
    render(conn, "show.json", time_block: time_block)
  end

  def update(conn, %{"id" => id, "time_block" => time_block_params}) do
    time_block = TimeBlocks.get_time_block!(id)

    with {:ok, %TimeBlock{} = time_block} <- TimeBlocks.update_time_block(time_block, time_block_params) do
      render(conn, "show.json", time_block: time_block)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_block = TimeBlocks.get_time_block!(id)

    with {:ok, %TimeBlock{}} <- TimeBlocks.delete_time_block(time_block) do
      send_resp(conn, :no_content, "")
    end
  end
end
