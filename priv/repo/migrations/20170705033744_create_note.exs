defmodule Crm.Repo.Migrations.CreateNote do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :body, :text
      add :user_id, references(:users, on_delete: :delete_all)
      add :contact_id, references(:contacts, on_delete: :delete_all)

      timestamps()
    end
    create index(:notes, [:user_id])
    create index(:notes, [:contact_id])

  end
end
