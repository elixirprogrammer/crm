defmodule Crm.ContactGroupsTest do
  use Crm.ModelCase

  alias Crm.ContactGroups

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ContactGroups.changeset(%ContactGroups{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ContactGroups.changeset(%ContactGroups{}, @invalid_attrs)
    refute changeset.valid?
  end
end
