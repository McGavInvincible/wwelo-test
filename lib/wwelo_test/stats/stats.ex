defmodule WweloTest.Stats do
  @moduledoc """
  The Stats context.
  """

  import Ecto.Query, warn: false
  alias WweloTest.Repo

  alias WweloTest.Stats.Wrestler

  @doc """
  Returns the list of wrestlers.

  ## Examples

      iex> list_wrestlers()
      [%Wrestler{}, ...]

  """
  def list_wrestlers do
    Repo.all(Wrestler)
  end

  @doc """
  Gets a single wrestler.

  Raises `Ecto.NoResultsError` if the Wrestler does not exist.

  ## Examples

      iex> get_wrestler!(123)
      %Wrestler{}

      iex> get_wrestler!(456)
      ** (Ecto.NoResultsError)

  """
  def get_wrestler!(id), do: Repo.get!(Wrestler, id)

  @doc """
  Creates a wrestler.

  ## Examples

      iex> create_wrestler(%{field: value})
      {:ok, %Wrestler{}}

      iex> create_wrestler(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_wrestler(attrs \\ %{}) do
    %Wrestler{}
    |> Wrestler.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a wrestler.

  ## Examples

      iex> update_wrestler(wrestler, %{field: new_value})
      {:ok, %Wrestler{}}

      iex> update_wrestler(wrestler, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_wrestler(%Wrestler{} = wrestler, attrs) do
    wrestler
    |> Wrestler.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Wrestler.

  ## Examples

      iex> delete_wrestler(wrestler)
      {:ok, %Wrestler{}}

      iex> delete_wrestler(wrestler)
      {:error, %Ecto.Changeset{}}

  """
  def delete_wrestler(%Wrestler{} = wrestler) do
    Repo.delete(wrestler)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking wrestler changes.

  ## Examples

      iex> change_wrestler(wrestler)
      %Ecto.Changeset{source: %Wrestler{}}

  """
  def change_wrestler(%Wrestler{} = wrestler) do
    Wrestler.changeset(wrestler, %{})
  end

# response=HTTPoison.get!("https://www.cagematch.net/?id=112&view=search&sParticipant1=&sParticipant2=&sParticipant3=&sParticipant4=&sEventName=&sEventType=TV-Show%7CPay+Per+View&sDateFromDay=01&sDateFromMonth=01&sDateFromYear=2017&sDateTillDay=31&sDateTillMonth=12&sDateTillYear=2017&sPromotion=1&sLocation=&sArena=&sRegion=&sMatchType=&sConstellation=&sWorkerRelationship=Any&sFulltextSearch=")
# html=Floki.parse(response.body)  
# matches=Floki.find(html, ".TBase")
# matchcards=Floki.find(matches, ".MatchCard")
# {_, _, [name]} = Enum.at(matchcards,2) |> elem(2) |> Enum.at(0)

end
