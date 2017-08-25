defmodule WweloTest.Repo.Migrations.CreateWrestlers do
  use Ecto.Migration

  def change do
    create table(:wrestlers) do
      add :wrestler_id, :integer
      add :wrestler_name, :string
      add :current_elo, :integer

      timestamps()
    end

  end
end
