defmodule Crm.Contact do
  use Crm.Web, :model

  alias Crm.{Repo, Contact}

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
    |> validate_required([:name, :email, :phone])
  end

  def all(user_id, params) do
    Contact
    |> where(user_id: ^user_id)
    |> preload(:contact_group)
    |> Repo.paginate(params)
  end

  def all_contacts_for_group(group_id, params) do
    Contact
    |> where(contact_group_id: ^group_id)
    |> preload(:contact_group)
    |> Repo.paginate(params)
  end

  def search(user_id, search_params, params) do
    from(c in Contact,
      where: c.user_id == ^user_id and ilike(c.name, ^"%#{search_params}%"),
      preload: :contact_group
    )
    |> Repo.paginate(params)
  end
end
