defmodule ElmIsFun.PageView do
  use ElmIsFun.Web, :view

  def render("credentials.json", assigns) do
    %{
      host: assigns.host,
      credential: assigns.credential,
      date: assigns.date,
      policy: assigns.policy,
      signature: assigns.signature
    }
  end
end
