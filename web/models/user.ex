defmodule Crm.User do
  use Crm.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    has_many :contacts, Crm.Contact
    has_many :contact_groups, Crm.ContactGroup
    has_many :notes, Crm.Note

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username, :password, :password_confirmation])
    |> validate_required([:name, :username, :password, :password_confirmation])
    |> validate_length(:username, min: 5, max: 20)
    |> validate_format(:username, ~r/^[a-zA-Z0-9_.-]*$/, message: "Please use letters and numbers without space(only characters allowed _ . -)")
    |> unique_constraint(:username)
  end

  def reg_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> cast(params, [:password], [])
    |> validate_length(:password, min: 8, max: 100)
    |> validate_format(:password, ~r/^[a-zA-Z0-9_.-]*$/, message: "Please use letters and numbers without space(only characters allowed _ . -)")
    |> validate_format(:password, ~r/^(?=.*[a-zA-Z])(?=.*[0-9])/, message: "Password must contain letters and numbers")
    |> validate_confirmation(:password)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Hasher.salted_password_hash(pass))
      _ ->
        changeset
    end
  end
end
