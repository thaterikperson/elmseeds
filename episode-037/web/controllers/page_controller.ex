defmodule ElmIsFun.PageController do
  use ElmIsFun.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def wins(conn, _params) do
    :timer.sleep(2000)
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(200, Poison.encode!(10, pretty: true))
  end

  def games(conn, _params) do
    :timer.sleep(1000)
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(200, Poison.encode!(17, pretty: true))
  end
end
