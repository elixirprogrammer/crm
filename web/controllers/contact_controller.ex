defmodule Crm.ContactController do
  use Crm.Web, :controller

  def index(conn, _params) do
    render conn, :index
  end
end
