defmodule Crm.ContactController do
  use Crm.Web, :controller
  use Drab.Controller

  alias Crm.Contact
  alias Crm.ContactGroup

  plug :assign_user_id_to_session when not action in [:new]

  def index(conn, _params) do
    render conn, :index
  end

  def new(conn, _params) do
    groups = Repo.all(ContactGroup)
    changeset = Contact.changeset(%Contact{})
    render conn, :new, changeset: changeset, groups: groups
  end

  defp assign_user_id_to_session(conn, _) do
    current_user = conn.current_user
    if conn.assigns.current_user do
      conn = put_session(conn, :user_id, current_user.id)
    end
    conn
  end
end
