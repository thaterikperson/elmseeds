defmodule ElmIsFun.Router do
  use ElmIsFun.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    #plug :fetch_session
    #plug :fetch_flash
    #plug :protect_from_forgery
    #plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElmIsFun do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/signin", PageController, :signin
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElmIsFun do
  #   pipe_through :api
  # end
end
