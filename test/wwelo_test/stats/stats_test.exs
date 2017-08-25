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
end
