defmodule WweloTestWeb.WrestlerControllerTest do
  use WweloTestWeb.ConnCase

  alias WweloTest.Stats

  @create_attrs %{current_elo: 42, name: "some name"}
  @update_attrs %{current_elo: 43, name: "some updated name"}
  @invalid_attrs %{current_elo: nil, name: nil}

  def fixture(:wrestler) do
    {:ok, wrestler} = Stats.create_wrestler(@create_attrs)
    wrestler
  end

  describe "index" do
    test "lists all wrestlers", %{conn: conn} do
      conn = get conn, wrestler_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Wrestlers"
    end
  end

  describe "new wrestler" do
    test "renders form", %{conn: conn} do
      conn = get conn, wrestler_path(conn, :new)
      assert html_response(conn, 200) =~ "New Wrestler"
    end
  end

  describe "create wrestler" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, wrestler_path(conn, :create), wrestler: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == wrestler_path(conn, :show, id)

      conn = get conn, wrestler_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Wrestler"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, wrestler_path(conn, :create), wrestler: @invalid_attrs
      assert html_response(conn, 200) =~ "New Wrestler"
    end
  end

  describe "edit wrestler" do
    setup [:create_wrestler]

    test "renders form for editing chosen wrestler", %{conn: conn, wrestler: wrestler} do
      conn = get conn, wrestler_path(conn, :edit, wrestler)
      assert html_response(conn, 200) =~ "Edit Wrestler"
    end
  end

  describe "update wrestler" do
    setup [:create_wrestler]

    test "redirects when data is valid", %{conn: conn, wrestler: wrestler} do
      conn = put conn, wrestler_path(conn, :update, wrestler), wrestler: @update_attrs
      assert redirected_to(conn) == wrestler_path(conn, :show, wrestler)

      conn = get conn, wrestler_path(conn, :show, wrestler)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, wrestler: wrestler} do
      conn = put conn, wrestler_path(conn, :update, wrestler), wrestler: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Wrestler"
    end
  end

  describe "delete wrestler" do
    setup [:create_wrestler]

    test "deletes chosen wrestler", %{conn: conn, wrestler: wrestler} do
      conn = delete conn, wrestler_path(conn, :delete, wrestler)
      assert redirected_to(conn) == wrestler_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, wrestler_path(conn, :show, wrestler)
      end
    end
  end

  defp create_wrestler(_) do
    wrestler = fixture(:wrestler)
    {:ok, wrestler: wrestler}
  end
end
