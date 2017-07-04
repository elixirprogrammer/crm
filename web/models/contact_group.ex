defmodule Crm.ContactGroup do
  use Crm.Web, :model

  schema "contact_groups" do
    field :name, :string
    belongs_to :user, Crm.User
    has_many :contacts, Crm.Contact

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
