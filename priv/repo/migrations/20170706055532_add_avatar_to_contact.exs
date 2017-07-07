defmodule Crm.Repo.Migrations.AddAvatarToContact do
  use Ecto.Migration

  def change do
    alter table(:contacts) do
      add :avatar, :string
    end
  end
end
