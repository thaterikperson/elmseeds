defmodule ElmIsFun.PageController do
  use ElmIsFun.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    {count, _} = Integer.parse(params["count"])
    render conn, "create.json", hands: count
  end
end
