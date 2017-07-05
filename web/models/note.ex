defmodule Crm.Note do
  use Crm.Web, :model

  alias Crm.{Repo, Note}

  schema "notes" do
    field :body, :string
    belongs_to :user, Crm.User
    belongs_to :contact, Crm.Contact

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end

  def all(contact_id, params) do
    Note
    |> where(contact_id: ^contact_id)
    |> Repo.paginate(params)
  end
end
