defmodule ElmIsFun.AllChannel do
  use ElmIsFun.Web, :channel

  def join(_, params, socket) do
    {:ok, socket}
  end
end
