defmodule WweloTestWeb.MatchesController do
  use WweloTestWeb, :controller

  alias WweloTest.Stats
  alias WweloTest.Stats.Matches

  def index(conn, _params) do
    matches = Stats.list_matches()
    render(conn, "index.html", matches: matches)
  end

  def new(conn, _params) do
    changeset = Stats.change_matches(%Matches{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"matches" => matches_params}) do
    case Stats.create_matches(matches_params) do
      {:ok, matches} ->
        conn
        |> put_flash(:info, "Matches created successfully.")
        |> redirect(to: matches_path(conn, :show, matches))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    matches = Stats.get_matches!(id)
    render(conn, "show.html", matches: matches)
  end

  def edit(conn, %{"id" => id}) do
    matches = Stats.get_matches!(id)
    changeset = Stats.change_matches(matches)
    render(conn, "edit.html", matches: matches, changeset: changeset)
  end

  def update(conn, %{"id" => id, "matches" => matches_params}) do
    matches = Stats.get_matches!(id)

    case Stats.update_matches(matches, matches_params) do
      {:ok, matches} ->
        conn
        |> put_flash(:info, "Matches updated successfully.")
        |> redirect(to: matches_path(conn, :show, matches))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", matches: matches, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    matches = Stats.get_matches!(id)
    {:ok, _matches} = Stats.delete_matches(matches)

    conn
    |> put_flash(:info, "Matches deleted successfully.")
    |> redirect(to: matches_path(conn, :index))
  end
end
