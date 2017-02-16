defmodule ElmIsFun.PageView do
  use ElmIsFun.Web, :view

  def render("large.json", assigns) do
    assigns[:text]
  end
end
