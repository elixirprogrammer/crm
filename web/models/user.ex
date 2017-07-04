defmodule Crm.Users do
  use Crm.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :password_hash, :string
    has_many :contacts, Crm.Contact
    has_many :contact_groups, Crm.ContactGroup

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username, :password_hash])
    |> validate_required([:name, :username, :password_hash])
  end
end
