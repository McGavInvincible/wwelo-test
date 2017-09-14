defmodule WweloTest.Stats.Wrestler do
  use Ecto.Schema
  import Ecto.Changeset
  alias WweloTest.Stats.Wrestler


  schema "wrestlers" do
    field :current_elo, :integer
    field :maximum_elo, :integer
    field :minimum_elo, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Wrestler{} = wrestler, attrs) do
    wrestler
    |> cast(attrs, [:name, :current_elo, :maximum_elo, :minimum_elo])
    |> validate_required([:name, :current_elo, :maximum_elo, :minimum_elo])
    |> unique_constraint(:name)
  end
end
