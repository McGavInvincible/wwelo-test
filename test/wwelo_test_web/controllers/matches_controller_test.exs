defmodule WweloTestWeb.MatchesControllerTest do
  use WweloTestWeb.ConnCase

  alias WweloTest.Stats

  @create_attrs %{date: "some date", loser: "some loser", loser_elo: 42, winner: "some winner", winner_elo: 42}
  @update_attrs %{date: "some updated date", loser: "some updated loser", loser_elo: 43, winner: "some updated winner", winner_elo: 43}
  @invalid_attrs %{date: nil, loser: nil, loser_elo: nil, winner: nil, winner_elo: nil}

  def fixture(:matches) do
    {:ok, matches} = Stats.create_matches(@create_attrs)
    matches
  end

  describe "index" do
    test "lists all matches", %{conn: conn} do
      conn = get conn, matches_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Matches"
    end
  end

  describe "new matches" do
    test "renders form", %{conn: conn} do
      conn = get conn, matches_path(conn, :new)
      assert html_response(conn, 200) =~ "New Matches"
    end
  end

  describe "create matches" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, matches_path(conn, :create), matches: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == matches_path(conn, :show, id)

      conn = get conn, matches_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Matches"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, matches_path(conn, :create), matches: @invalid_attrs
      assert html_response(conn, 200) =~ "New Matches"
    end
  end

  describe "edit matches" do
    setup [:create_matches]

    test "renders form for editing chosen matches", %{conn: conn, matches: matches} do
      conn = get conn, matches_path(conn, :edit, matches)
      assert html_response(conn, 200) =~ "Edit Matches"
    end
  end

  describe "update matches" do
    setup [:create_matches]

    test "redirects when data is valid", %{conn: conn, matches: matches} do
      conn = put conn, matches_path(conn, :update, matches), matches: @update_attrs
      assert redirected_to(conn) == matches_path(conn, :show, matches)

      conn = get conn, matches_path(conn, :show, matches)
      assert html_response(conn, 200) =~ "some updated date"
    end

    test "renders errors when data is invalid", %{conn: conn, matches: matches} do
      conn = put conn, matches_path(conn, :update, matches), matches: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Matches"
    end
  end

  describe "delete matches" do
    setup [:create_matches]

    test "deletes chosen matches", %{conn: conn, matches: matches} do
      conn = delete conn, matches_path(conn, :delete, matches)
      assert redirected_to(conn) == matches_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, matches_path(conn, :show, matches)
      end
    end
  end

  defp create_matches(_) do
    matches = fixture(:matches)
    {:ok, matches: matches}
  end
end
