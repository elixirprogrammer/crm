defmodule Crm.LayoutView do
  use Crm.Web, :view

  def first_name(%Crm.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
