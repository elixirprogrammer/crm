defmodule Crm.ContactsTest do
  use Crm.ModelCase

  alias Crm.Contacts

  @valid_attrs %{address: "some content", company: "some content", email: "some content", name: "some content", phone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Contacts.changeset(%Contacts{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Contacts.changeset(%Contacts{}, @invalid_attrs)
    refute changeset.valid?
  end
end
