defmodule Crm.ContactGroupController do
  use Crm.Web, :controller

  alias Crm.{ContactGroup}

  def index(conn, _params) do
    groups = ContactGroup.all(conn.assigns.current_user.id)

    render(conn, :index, groups: groups)
  end

  def delete(conn, %{"id" => id}) do
    group = Repo.get!(ContactGroup, id) |> Repo.preload(:user)
    if group.user !== conn.assigns.current_user do
      conn
      |> put_flash(:error, "You are not the owner of that group.")
      |> redirect(to: "/")
    else
      Repo.delete!(group)

      conn
      |> put_flash(:info, "Group #{group.name} deleted successfully.")
      |> redirect(to: contact_group_path(conn, :index))
    end
  end
end
