defmodule DatabaseScraper do

  alias WweloTest.Repo
  alias WweloTest.Stats
  alias WweloTest.Stats.Wrestler

  def save_singles_matches do
    Enum.map(list_of_singles_matches(), fn(x) -> save_matches_to_database(x) end)
  end

  def list_of_singles_matches do
    table_contents = get_table_contents("https://www.cagematch.net/?id=112&view=search&sEventType=TV-Show|Pay%20Per%20View&sDateFromDay=01&sDateFromMonth=01&sDateFromYear=2017&sDateTillDay=31&sDateTillMonth=12&sDateTillYear=2017&sPromotion=1&sWorkerRelationship=Any&s=0")

    get_singles_matches_from_table(table_contents)
  end

  def get_table_contents(link) do
    response=HTTPoison.get!(link)

    Floki.parse(response.body)
    |> Floki.find(".TBase")
    |> Enum.at(0)
    |> elem(2)
    |> Enum.map(fn(x) -> elem(x, 2) end)
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

    {_, _, [winner]} = Enum.at(matchcard, 0)
    {_, _, [loser]} = Enum.at(matchcard, 2)

    Stats.create_matches(%{"winner" => winner, "loser" => loser, "date" => date})

    save_wrestler_to_database(Repo.get_by(Wrestler, name: winner), winner)
    save_wrestler_to_database(Repo.get_by(Wrestler, name: loser), loser)
  end

  def save_wrestler_to_database(nil, name) do
    Stats.create_wrestler(%{"name" => name, "current_elo" => 1200})
  end
  def save_wrestler_to_database(_, _) do
  end

end
