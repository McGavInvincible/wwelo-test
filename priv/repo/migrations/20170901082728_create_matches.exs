defmodule WweloTest.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :date, :string
      add :winner, :string
      add :winner_elo, :integer
      add :loser, :string
      add :loser_elo, :integer

      timestamps()
    end

  end
end
