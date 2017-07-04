defmodule Crm.ContactView do
  use Crm.Web, :view

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
end
