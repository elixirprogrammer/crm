defmodule Crm.PageController do
  use Crm.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
