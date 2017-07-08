defmodule Crm.Contact do
  use Crm.Web, :model
  use Arc.Ecto.Schema

  alias Crm.{Repo, Contact}

  schema "contacts" do
    field :name, :string
    field :company, :string
    field :email, :string
    field :phone, :string
    field :address, :string
    field :avatar, Crm.Avatar.Type
    belongs_to :user, Crm.User
    belongs_to :contact_group, Crm.ContactGroup
    has_many :notes, Crm.Note

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :company, :email, :phone, :address, :contact_group_id])
    |> validate_required([:name, :email, :phone, :contact_group_id])
  end

  def file_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> cast_attachments(params, [:avatar])
    |> valid_file(params)
  end

  defp valid_file(changeset, params) do
    if Map.has_key?(params, "avatar") do
      extension = ~w(.jpg .jpeg .gif .png)
      message = "Only (.jpg .jpeg .gif .png) files allowed"
      file = params["avatar"].filename
      |> Path.extname
      |> String.downcase

      unless Enum.member?(extension, file) do
        changeset = add_error(changeset, :avatar, message)
      end
      changeset
    else
      changeset
    end
  end

  def all(user_id, params) do
    Contact
    |> where(user_id: ^user_id)
    |> order_by(:name)
    |> preload(:contact_group)
    |> Repo.paginate(params)
  end

  def all_contacts_for_group(group_id, params) do
    Contact
    |> where(contact_group_id: ^group_id)
    |> order_by(:name)
    |> preload(:contact_group)
    |> Repo.paginate(params)
  end

  def search(user_id, search_params, params) do
    from(c in Contact,
      where: c.user_id == ^user_id and ilike(c.name, ^"%#{search_params}%"),
      order_by: c.name,
      preload: :contact_group
    )
    |> Repo.paginate(params)
  end

  def count(user_id) do
    hd Repo.all(
      from c in Contact,
      select: count(c.id),
      where: c.user_id == ^user_id
    )
  end
end
