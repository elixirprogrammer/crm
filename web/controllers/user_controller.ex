defmodule Crm.UserController do
  use Crm.Web, :controller

  alias Crm.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    authenticate_current_user_can(conn, user)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    authenticate_current_user_can(conn, user)
    changeset = User.reg_changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} updated successfully.")
        |> redirect(to: contact_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.reg_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Crm.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: contact_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp authenticate_current_user_can(conn, user) do
    unless conn.assigns.current_user == user do
      conn
      |> put_flash(:error, "You are not the owner of that user")
      |> redirect(to: contact_path(conn, :index))
    end
  end
end
