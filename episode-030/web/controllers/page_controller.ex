defmodule ElmIsFun.PageController do
  use ElmIsFun.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def data(conn, _params) do
    data = [
      %{day: 0, wins: 0, losses: 0, gain: 0.0},
      %{day: 1, wins: 12, losses: 14, gain: -5.0},
      %{day: 2, wins: 13, losses: 14, gain: 0.0},
      %{day: 3, wins: 10, losses: 14, gain: -15.0},
      %{day: 4, wins: 24, losses: 14, gain: 50.0},
      %{day: 5, wins: 26, losses: 14, gain: 75.0},
      %{day: 6, wins: 12, losses: 14, gain: -5.0},
      %{day: 7, wins: 12, losses: 14, gain: -15.0},
      %{day: 8, wins: 13, losses: 14, gain: 5.0},
      %{day: 9, wins: 8, losses: 14, gain: -15.0},
      %{day: 10, wins: 3, losses: 14, gain: -45.0},
      %{day: 11, wins: 2, losses: 14, gain: -45.0},
      %{day: 12, wins: 12, losses: 14, gain: -5.0},
      %{day: 13, wins: 13, losses: 14, gain: -5.0},
    ]
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(200, Poison.encode!(data, pretty: true))
  end
end
