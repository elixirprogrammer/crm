defmodule Crm.ContactController do
  use Crm.Web, :controller
  use Drab.Controller

  alias Crm.{Contact, ContactGroup}

  plug :assign_user_id_to_session when action in [:new]

  def index(conn, _params) do
    render conn, :index
  end

  def new(conn, _params) do
    groups = Repo.all(ContactGroup)
    changeset = Contact.changeset(%Contact{})
    render conn, :new, changeset: changeset, groups: groups
  end

  def create(conn, %{"contact" => contact_params}) do
    groups = Repo.all(ContactGroup)
    group = String.to_integer(contact_params["contact_group_id"])
    changeset = Contact.changeset(%Contact{
      contact_group_id: group,
      user_id: conn.assigns.current_user.id
    }, contact_params)

    case Repo.insert(changeset) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "#{contact.name} created!")
        |> redirect(to: contact_path(conn, :index))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset, groups: groups)
    end
  end

  defp assign_user_id_to_session(conn, _) do
    if conn.assigns.current_user do
      conn = put_session(conn, :user_id, conn.assigns.current_user.id)
    end
    conn
  end
end
