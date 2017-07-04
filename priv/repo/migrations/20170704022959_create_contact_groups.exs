defmodule Crm.Repo.Migrations.CreateContactGroups do
  use Ecto.Migration

  def change do
    create table(:contact_groups) do
      add :name, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:contact_groups, [:user_id])

  end
end
