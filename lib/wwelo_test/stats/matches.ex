defmodule WweloTest.Stats.Matches do
  use Ecto.Schema
  import Ecto.Changeset
  alias WweloTest.Stats.Matches


  schema "matches" do
    field :date, :string
    field :loser, :string
    field :loser_elo, :integer
    field :winner, :string
    field :winner_elo, :integer

    timestamps()
  end

  @doc false
  def changeset(%Matches{} = matches, attrs) do
    matches
    |> cast(attrs, [:date, :winner, :winner_elo, :loser, :loser_elo])
    |> validate_required([:date, :winner, :winner_elo, :loser, :loser_elo])
  end
end
