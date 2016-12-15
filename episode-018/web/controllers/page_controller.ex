defmodule ElmIsFun.PageController do
  use ElmIsFun.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    {count, _} = Integer.parse(params["count"])
    if rem(count, 2) == 0 do
      render conn, "create.json", hands: count
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render("error.json", message: "invalid count")
    end
  end
end
