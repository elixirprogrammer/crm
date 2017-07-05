defmodule Crm.Note do
  use Crm.Web, :model

  schema "notes" do
    field :body, :string
    belongs_to :user, Crm.User
    belongs_to :contact_group, Crm.ContactGroup

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
end
