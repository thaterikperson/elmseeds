defmodule ElmIsFun.PageController do
  use ElmIsFun.Web, :controller

  alias ElmIsFun.Signing

  def index(conn, _params) do
    render conn, "index.html"
  end

  def credentials(conn, _params) do
    credential = Signing.credential()
    date = Signing.get_date() <> "T000000Z"
    policy = Signing.policy64(url(conn))
    signature = Signing.signature(url(conn), 30)

    render conn, "credentials.json", %{
      host: url(conn),
      credential: credential,
      date: date,
      policy: policy,
      signature: signature
    }
  end
end
