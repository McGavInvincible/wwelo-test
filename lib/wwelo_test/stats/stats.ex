defmodule WweloTest.Stats do
  @moduledoc """
  The Stats context.
  """

  import Ecto.Query, warn: false
  alias WweloTest.Repo

  alias WweloTest.Stats.Wrestler
  alias WweloTest.Stats.Matches
  
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

  def list_matches do
    Repo.all(Matches)
  end

  def get_matches!(id), do: Repo.get!(Matches, id)

  def create_matches(attrs \\ %{}) do
    %Matches{}
    |> Matches.changeset(attrs)
    |> Repo.insert()
  end

  def update_matches(%Matches{} = matches, attrs) do
    matches
    |> Matches.changeset(attrs)
    |> Repo.update()
  end

  def delete_matches(%Matches{} = matches) do
    Repo.delete(matches)
  end

  def change_matches(%Matches{} = matches) do
    Matches.changeset(matches, %{})
  end
end
