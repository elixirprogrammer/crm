defmodule Crm.PageController do
  use Crm.Web, :controller

  def index(conn, _params) do
    if conn.assigns.current_user do
      conn
      |> redirect(to: contact_path(conn, :index))
    else
      render conn, :index
    end
  end
end
