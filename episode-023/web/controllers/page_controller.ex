defmodule ElmIsFun.PageController do
  use ElmIsFun.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def large(conn, params) do
    Process.sleep(1_000)
    text =
      :crypto.strong_rand_bytes(100_000)
      |> Base.encode64(padding: false)

    render conn, "large.json", text: text
  end
end
