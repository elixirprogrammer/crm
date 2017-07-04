defmodule Crm.ContactController do
  use Crm.Web, :controller
  use Drab.Controller

  alias Crm.{Contact, ContactGroup}

  plug :assign_user_id_to_session when action in [:new]

  def index(conn, _params) do
    groups = ContactGroup.all(conn.assigns.current_user.id)
    contacts = Contact.all(conn.assigns.current_user.id)

    render conn, :index, contacts: contacts, groups: groups
  end

  def groups(conn, params) do
    group_id = String.to_integer(params["id"])
    groups = ContactGroup.all(conn.assigns.current_user.id)
    contacts = Contact.all_contacts_for_group(group_id)

    render conn, :groups, contacts: contacts, groups: groups
  end

  def new(conn, _params) do
    groups = ContactGroup.all(conn.assigns.current_user.id)
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
