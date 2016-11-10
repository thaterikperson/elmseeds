defmodule ElmIsFun.PageView do
  use ElmIsFun.Web, :view

  def render("create.json", _assigns) do
    %{ok: "ok"}
  end
end
