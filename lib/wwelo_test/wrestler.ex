defmodule WweloTest.Wrestler do
  use Ecto.Schema
  import Ecto.Changeset
  alias WweloTest.Wrestler


  schema "wrestlers" do
    field :current_elo, :integer
    field :wrestler_name, :string

    timestamps()
  end

  @doc false
  def changeset(%Wrestler{} = wrestler, attrs) do
    wrestler
    |> cast(attrs, [:wrestler_name, :current_elo])
    |> validate_required([:wrestler_name, :current_elo])
  end
end
