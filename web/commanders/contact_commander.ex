defmodule Crm.ContactCommander do
  use Drab.Commander

  alias Crm.{ContactGroup, Note, Repo}

  access_session [:user_id, :contact_id]

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

  def add_contact_note(socket, sender) do
    form = "<textarea class='form-control' name='note' rows='6'></textarea>"
    note = case socket |> alert("Add Note", form, buttons: [ok: "Save", cancel: "Cancel"]) do
      { :ok, params } -> add_note(socket, params["note"])
      { :cancel, _ }  -> "anonymous"
    end
  end

  def add_note(socket, note) do
    contact = get_session(socket, :contact_id)
    user = get_session(socket, :user_id)
    changeset = Note.changeset(%Note{
      user_id: user,
      contact_id: contact}, %{body: note})

    case Repo.insert(changeset) do
      {:ok, note} ->
        html = render_to_string("_note.html", [note: note])
        socket |> insert(html, prepend: "#contact-note-list")
      {:error, changeset} ->
        socket |> exec_js("alert('The note cannot be empty')")
    end
  end
end
