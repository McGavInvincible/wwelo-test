defmodule WweloTest.Repo.Migrations.CreateWrestlers do
  use Ecto.Migration

  def change do
    create table(:wrestlers) do
      add :name, :string
      add :current_elo, :integer
      add :maximum_elo, :integer
      add :minimum_elo, :integer

      timestamps()
    end

    create unique_index(:wrestlers, [:name])
  end
end
