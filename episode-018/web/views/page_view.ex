defmodule ElmIsFun.PageView do
  use ElmIsFun.Web, :view

  def render("create.json", assigns) do
    %{
      status: "ok",
      number_of_hands: assigns[:hands] || 0,
      number_of_wins: 0,
      favorite_casino: nil,
    }
  end

  def render("error.json", assigns) do
    %{error: assigns[:message]}
  end
end
