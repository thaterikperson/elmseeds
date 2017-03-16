defmodule ElmIsFun.PageController do
  use ElmIsFun.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def person(conn, _params) do
    data =
      %{
        username: "elmseeds",
        url: "https://elmseeds.thaterikperson.com",
        bank: 100.00,
        lastBetSize: 5.0,
        handsPlayed: 103,
        handsWon: 47,
        averageBet: 22.5,
        lastPlayedAt: "2016-09-12T13:15:00.000Z",
        favoriteCasino: "Belagio"
      }
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(200, Poison.encode!(data, pretty: true))
  end
end
