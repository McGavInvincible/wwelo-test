defmodule DatabaseScraper do

  import Ecto.Query

  alias WweloTest.Repo
  alias WweloTest.Stats
  alias WweloTest.Stats.Matches
  alias WweloTest.Stats.Wrestler

  @start_elo 1200

  def save_singles_matches(year, month, page_number) do
    Enum.each(list_of_singles_matches(year, month, page_number), fn(match_list) ->
      case match_list do
        [] -> []
        _ -> save_matches_to_database(match_list)
      end
    end)
  end
  def save_singles_matches do
    wwe_years = 1963..2017
    months = 1..12

    Enum.each(wwe_years, fn(year) ->
      IO.inspect(year)
      Enum.each(months, fn(month) ->
        page_results = number_of_page_results(year, month)
        case page_results do
            0 -> 0
          _ -> Enum.each(1..page_results, fn(page_number) ->
            save_singles_matches(year, month, page_number)
            end)
        end
      end)
    end)
  end

  def search_link(year, month, page_number) do
    results_number = (page_number - 1)*100

     "https://www.cagematch.net/?id=112&view=search&sEventType=TV-Show|Pay%20Per%20View&sDateFromDay=01&sDateFromMonth=#{month}&sDateFromYear=#{year}&sDateTillDay=31&sDateTillMonth=#{month}&sDateTillYear=#{year}&sPromotion=1&s=#{results_number}"
  end

  def number_of_page_results(year, month) do
    response=HTTPoison.get!(search_link(year, month, 1))

    list_of_pages = Floki.find(response.body, ".NavigationPartPage")
    |> Enum.uniq
    |> Enum.map(fn(x) -> elem(x,2)
    |> Enum.at(0)
    |> Integer.parse end)

    case list_of_pages do
      [] -> 1
      _ -> Enum.max(list_of_pages) |> elem(0)
    end
  end

  def list_of_singles_matches(year, month, page_number) do
    table_contents = get_table_contents(search_link(year, month, page_number))

    case table_contents do
      [] -> []
      _ -> get_singles_matches_from_table(table_contents)
    end
  end

  def get_table_contents(link) do
    response=HTTPoison.get!(link)

    page_contents = Floki.parse(response.body)
    |> Floki.find(".TBase")
    |> Enum.at(0)

    case page_contents do
      nil -> []
      _ -> elem(page_contents,2) |> Enum.map(fn(x) -> elem(x, 2) end)
    end
  end

  def get_singles_matches_from_table(table_contents) do
    tl(table_contents)
    |> Enum.filter(fn(x) -> Enum.at(x, 3)
    |> Floki.find(".MatchCard")
    |> Enum.at(0)
    |> elem(2)
    |> Enum.filter(fn(y) -> is_tuple(y) end)
    |> Enum.filter(fn(z) -> elem(z, 0) == "a" end)
    |> length == 2 end)
  end

  def save_matches_to_database([_, {_, _, [date]}, _, matchcard, _]) do

    [day, month, year] = String.split(date, ".")
    date = year <> month <> day

    matchcard = Floki.find(matchcard, ".MatchCard") |> Enum.at(0) |> elem(2)

    matchcard = Enum.filter(matchcard, fn x -> case x
      do
        {"a", [{"href", _}] , _} -> true
        _ -> false
      end
    end)

    [{_, _, [winner]}, {_, _, [loser]}] = matchcard

    winner = case String.valid?(winner) do
      false -> Enum.join(for <<c::utf8 <- winner>>, do: <<c::utf8>>)
      _ -> winner
    end
    loser = case String.valid?(loser) do
      false -> Enum.join(for <<c::utf8 <- loser>>, do: <<c::utf8>>)
      _ -> loser
    end

    match_query = from m in Matches,
      where: m.loser == ^loser and m.winner == ^winner and m.date == ^date,
      select: m.id

    save_match_to_database(Repo.all(match_query), winner, loser, date)

    save_wrestler_to_database(Repo.get_by(Wrestler, name: winner), winner)
    save_wrestler_to_database(Repo.get_by(Wrestler, name: loser), loser)
  end

  def save_match_to_database([], winner, loser, date) do
    Stats.create_matches(%{"winner" => winner, "loser" => loser, "date" => date})
  end
  def save_match_to_database(_, _, _, _) do
  end

  def save_wrestler_to_database(nil, name) do
    Stats.create_wrestler(%{"name" => name, "current_elo" => @start_elo, "maximum_elo" => @start_elo, "minimum_elo" => @start_elo})
  end
  def save_wrestler_to_database(_, _) do
  end

end
