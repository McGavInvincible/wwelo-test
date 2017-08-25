defmodule WweloTestWeb.WrestlerController do
  use WweloTestWeb, :controller

  alias WweloTest.Stats
  alias WweloTest.Stats.Wrestler

  def index(conn, _params) do
    wrestlers = Stats.list_wrestlers()
    render(conn, "index.html", wrestlers: wrestlers)
  end

  def new(conn, _params) do
    changeset = Stats.change_wrestler(%Wrestler{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"wrestler" => wrestler_params}) do
    case Stats.create_wrestler(wrestler_params) do
      {:ok, wrestler} ->
        conn
        |> put_flash(:info, "Wrestler created successfully.")
        |> redirect(to: wrestler_path(conn, :show, wrestler))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    wrestler = Stats.get_wrestler!(id)
    render(conn, "show.html", wrestler: wrestler)
  end

  def edit(conn, %{"id" => id}) do
    wrestler = Stats.get_wrestler!(id)
    changeset = Stats.change_wrestler(wrestler)
    render(conn, "edit.html", wrestler: wrestler, changeset: changeset)
  end

  def update(conn, %{"id" => id, "wrestler" => wrestler_params}) do
    wrestler = Stats.get_wrestler!(id)

    case Stats.update_wrestler(wrestler, wrestler_params) do
      {:ok, wrestler} ->
        conn
        |> put_flash(:info, "Wrestler updated successfully.")
        |> redirect(to: wrestler_path(conn, :show, wrestler))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", wrestler: wrestler, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    wrestler = Stats.get_wrestler!(id)
    {:ok, _wrestler} = Stats.delete_wrestler(wrestler)

    conn
    |> put_flash(:info, "Wrestler deleted successfully.")
    |> redirect(to: wrestler_path(conn, :index))
  end
end
