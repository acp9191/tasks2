defmodule Tasks2Web.PageController do
  use Tasks2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
