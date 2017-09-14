defmodule WweloTest.StatsTest do
  use WweloTest.DataCase

  alias WweloTest.Stats

  describe "wrestlers" do
    alias WweloTest.Stats.Wrestler

    @valid_attrs %{current_elo: 42, name: "some name"}
    @update_attrs %{current_elo: 43, name: "some updated name"}
    @invalid_attrs %{current_elo: nil, name: nil}

    def wrestler_fixture(attrs \\ %{}) do
      {:ok, wrestler} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stats.create_wrestler()

      wrestler
    end

    test "list_wrestlers/0 returns all wrestlers" do
      wrestler = wrestler_fixture()
      assert Stats.list_wrestlers() == [wrestler]
    end

    test "get_wrestler!/1 returns the wrestler with given id" do
      wrestler = wrestler_fixture()
      assert Stats.get_wrestler!(wrestler.id) == wrestler
    end

    test "create_wrestler/1 with valid data creates a wrestler" do
      assert {:ok, %Wrestler{} = wrestler} = Stats.create_wrestler(@valid_attrs)
      assert wrestler.current_elo == 42
      assert wrestler.name == "some name"
    end

    test "create_wrestler/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_wrestler(@invalid_attrs)
    end

    test "update_wrestler/2 with valid data updates the wrestler" do
      wrestler = wrestler_fixture()
      assert {:ok, wrestler} = Stats.update_wrestler(wrestler, @update_attrs)
      assert %Wrestler{} = wrestler
      assert wrestler.current_elo == 43
      assert wrestler.name == "some updated name"
    end

    test "update_wrestler/2 with invalid data returns error changeset" do
      wrestler = wrestler_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_wrestler(wrestler, @invalid_attrs)
      assert wrestler == Stats.get_wrestler!(wrestler.id)
    end

    test "delete_wrestler/1 deletes the wrestler" do
      wrestler = wrestler_fixture()
      assert {:ok, %Wrestler{}} = Stats.delete_wrestler(wrestler)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_wrestler!(wrestler.id) end
    end

    test "change_wrestler/1 returns a wrestler changeset" do
      wrestler = wrestler_fixture()
      assert %Ecto.Changeset{} = Stats.change_wrestler(wrestler)
    end
  end

  describe "matches" do
    alias WweloTest.Stats.Matches

    @valid_attrs %{date: "some date", loser: "some loser", loser_elo: 42, winner: "some winner", winner_elo: 42}
    @update_attrs %{date: "some updated date", loser: "some updated loser", loser_elo: 43, winner: "some updated winner", winner_elo: 43}
    @invalid_attrs %{date: nil, loser: nil, loser_elo: nil, winner: nil, winner_elo: nil}

    def matches_fixture(attrs \\ %{}) do
      {:ok, matches} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stats.create_matches()

      matches
    end

    test "list_matches/0 returns all matches" do
      matches = matches_fixture()
      assert Stats.list_matches() == [matches]
    end

    test "get_matches!/1 returns the matches with given id" do
      matches = matches_fixture()
      assert Stats.get_matches!(matches.id) == matches
    end

    test "create_matches/1 with valid data creates a matches" do
      assert {:ok, %Matches{} = matches} = Stats.create_matches(@valid_attrs)
      assert matches.date == "some date"
      assert matches.loser == "some loser"
      assert matches.loser_elo == 42
      assert matches.winner == "some winner"
      assert matches.winner_elo == 42
    end

    test "create_matches/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_matches(@invalid_attrs)
    end

    test "update_matches/2 with valid data updates the matches" do
      matches = matches_fixture()
      assert {:ok, matches} = Stats.update_matches(matches, @update_attrs)
      assert %Matches{} = matches
      assert matches.date == "some updated date"
      assert matches.loser == "some updated loser"
      assert matches.loser_elo == 43
      assert matches.winner == "some updated winner"
      assert matches.winner_elo == 43
    end

    test "update_matches/2 with invalid data returns error changeset" do
      matches = matches_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_matches(matches, @invalid_attrs)
      assert matches == Stats.get_matches!(matches.id)
    end

    test "delete_matches/1 deletes the matches" do
      matches = matches_fixture()
      assert {:ok, %Matches{}} = Stats.delete_matches(matches)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_matches!(matches.id) end
    end

    test "change_matches/1 returns a matches changeset" do
      matches = matches_fixture()
      assert %Ecto.Changeset{} = Stats.change_matches(matches)
    end
  end

  describe "wrestlers" do
    alias WweloTest.Stats.Wrestler

    @valid_attrs %{current_elo: 42, maximum_elo: 42, minimum_elo: 42, name: "some name"}
    @update_attrs %{current_elo: 43, maximum_elo: 43, minimum_elo: 43, name: "some updated name"}
    @invalid_attrs %{current_elo: nil, maximum_elo: nil, minimum_elo: nil, name: nil}

    def wrestler_fixture(attrs \\ %{}) do
      {:ok, wrestler} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stats.create_wrestler()

      wrestler
    end

    test "list_wrestlers/0 returns all wrestlers" do
      wrestler = wrestler_fixture()
      assert Stats.list_wrestlers() == [wrestler]
    end

    test "get_wrestler!/1 returns the wrestler with given id" do
      wrestler = wrestler_fixture()
      assert Stats.get_wrestler!(wrestler.id) == wrestler
    end

    test "create_wrestler/1 with valid data creates a wrestler" do
      assert {:ok, %Wrestler{} = wrestler} = Stats.create_wrestler(@valid_attrs)
      assert wrestler.current_elo == 42
      assert wrestler.maximum_elo == 42
      assert wrestler.minimum_elo == 42
      assert wrestler.name == "some name"
    end

    test "create_wrestler/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_wrestler(@invalid_attrs)
    end

    test "update_wrestler/2 with valid data updates the wrestler" do
      wrestler = wrestler_fixture()
      assert {:ok, wrestler} = Stats.update_wrestler(wrestler, @update_attrs)
      assert %Wrestler{} = wrestler
      assert wrestler.current_elo == 43
      assert wrestler.maximum_elo == 43
      assert wrestler.minimum_elo == 43
      assert wrestler.name == "some updated name"
    end

    test "update_wrestler/2 with invalid data returns error changeset" do
      wrestler = wrestler_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_wrestler(wrestler, @invalid_attrs)
      assert wrestler == Stats.get_wrestler!(wrestler.id)
    end

    test "delete_wrestler/1 deletes the wrestler" do
      wrestler = wrestler_fixture()
      assert {:ok, %Wrestler{}} = Stats.delete_wrestler(wrestler)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_wrestler!(wrestler.id) end
    end

    test "change_wrestler/1 returns a wrestler changeset" do
      wrestler = wrestler_fixture()
      assert %Ecto.Changeset{} = Stats.change_wrestler(wrestler)
    end
  end
end
