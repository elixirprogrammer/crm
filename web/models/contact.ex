defmodule Crm.Contact do
  use Crm.Web, :model

  schema "contacts" do
    field :name, :string
    field :company, :string
    field :email, :string
    field :phone, :string
    field :address, :string
    belongs_to :user, Crm.User
    belongs_to :contact_group, Crm.ContactGroup

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :company, :email, :phone, :address])
    |> validate_required([:name, :company, :email, :phone, :address])
  end
end
