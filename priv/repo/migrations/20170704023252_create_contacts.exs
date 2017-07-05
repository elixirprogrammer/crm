defmodule Crm.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :name, :string
      add :company, :string
      add :email, :string
      add :phone, :string
      add :address, :text
      add :user_id, references(:users, on_delete: :delete_all)
      add :contact_group_id, references(:contact_groups, on_delete: :delete_all)

      timestamps()
    end
    create index(:contacts, [:user_id])
    create index(:contacts, [:contact_group_id])

  end
end
