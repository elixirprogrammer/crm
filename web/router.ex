defmodule Crm.Router do
  use Crm.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Crm.Auth, repo: Crm.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Crm do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/", Crm do
    pipe_through [:browser, :authenticate_user]

    resources "/contacts", ContactController
    resources "/users", UserController, only: [:edit, :update]
    get "/groups/:id", ContactController, :groups
    get "/search/contacts", ContactController, :search
  end

  scope "/manage", Crm do
    pipe_through [:browser, :authenticate_user]

    resources "/groups", ContactGroupController, only: [:index, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Crm do
  #   pipe_through :api
  # end
end
