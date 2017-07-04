defmodule Crm.ContactCommander do
  use Drab.Commander

  alias Crm.{ContactGroup, Repo}

  access_session :user_id

  def add_group(socket, sender) do
    user = get_session(socket, :user_id)
    group = socket |> select(:val, from: "#new_group")
    changeset = ContactGroup.changeset(%ContactGroup{user_id: user}, %{name: group})

    case Repo.insert(changeset) do
      {:ok, group} ->
        html = "<option value='#{group.id}'>#{group.name}</option>"
        socket |> insert(html, prepend: "#group")
        |> update(:val, set: "", on: "#new_group")
      {:error, changeset} ->
        socket |> exec_js("alert('The group name cannot be empty')")
    end
  end
end
