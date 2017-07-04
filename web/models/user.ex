defmodule Crm.Users do
  use Crm.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    has_many :contacts, Crm.Contact
    has_many :contact_groups, Crm.ContactGroup

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username, :password, :password_confirmation])
    |> validate_required([:name, :username, :password, :password_confirmation])
  end
end
