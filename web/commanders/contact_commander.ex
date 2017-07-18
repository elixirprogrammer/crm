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
        group_html = "<a class='list-group-item' href='/groups/#{group.id}'>#{group.name}</a>"
        html = "<option value='#{group.id}'>#{group.name}</option>"
        socket
        |> insert(group_html, prepend: "#group_list")
        |> insert(html, prepend: "#group")
        |> update(:val, set: "", on: "#new_group")
      {:error, changeset} ->
        socket |> exec_js("alert('The group name cannot be empty')")
    end
  end

  def add_contact_note(socket, _) do
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

  def edit_contact_note(socket, sender) do
    note_id = socket |> select(data: "noteId", from: this(sender))
    note = Repo.get!(Note, note_id)
    form = "<textarea class='form-control' name='note' rows='6'>#{note.body}</textarea>"
    note = case socket |> alert("Edit Note", form, buttons: [ok: "Save", cancel: "Cancel"]) do
      { :ok, params } -> edit_note(socket, note, params["note"])
      { :cancel, _ }  -> "anonymous"
    end
  end

  def edit_note(socket, note, note_param) do
    changeset = Note.changeset(note, %{body: note_param})
    case Repo.update(changeset) do
      {:ok, note} ->
        socket
        |> update(:text, set: note.body, on: "#note_id_#{note.id}")
      {:error, changeset} ->
        socket |> exec_js("alert('The note cannot be empty')")
    end
  end

  def delete_contact_note(socket, sender) do
    note_id = socket |> select(data: "noteId", from: this(sender))
    note = Repo.get!(Note, note_id)
    button = case socket |> alert("Message", "Are you Sure?", buttons: [ok: "YES", cancel: "NO"]) do
      { :ok, params } -> delete_note(socket, note)
      { :cancel, _ }  -> "anonymous"
    end
  end

  def delete_note(socket, note) do
    Repo.delete!(note)
    socket
    socket |> delete("#article_note_id_#{note.id}")
  end
end
