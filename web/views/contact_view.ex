defmodule Crm.ContactView do
  use Crm.Web, :view
  import Kerosene.HTML

  def gravatar_for(name, email, size \\ 80) do
    gravatar_id = hash(email)
    src ="https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&default=mm"
    img_tag(src, class: "img-circle", alt: name)
  end
  defp md5(str) do
    :crypto.hash(:md5 , str) |> Base.encode16(case: :lower)
  end
  defp hash(email) do
    email
    |> String.strip
    |> String.downcase
    |> md5()
  end

  def active_group?(conn, group_id) do
    if conn.params["id"] == Integer.to_string(group_id) do
      "list-group-item active"
    else
      "list-group-item"
    end
  end

  def active_group?(conn) do
    if conn.request_path == contact_path(conn, :index) do
      "list-group-item active"
    else
      "list-group-item"
    end
  end
end
