defmodule DatabaseScraper do

  alias WweloTest.Stats

  def list_of_matches do
    response=HTTPoison.get!("https://www.cagematch.net/?id=112&view=search&sEventType=TV-Show|Pay%20Per%20View&sDateFromDay=01&sDateFromMonth=01&sDateFromYear=2017&sDateTillDay=31&sDateTillMonth=12&sDateTillYear=2017&sPromotion=1&sWorkerRelationship=Any&s=0")

    table_contents = Floki.parse(response.body)
      |> Floki.find(".TBase")
      |> Enum.at(0)
      |> elem(2)
      |> Enum.map(fn(x) -> elem(x, 2) end)

    singles_table_contents = tl(table_contents)
      |> Enum.filter(fn(x) -> Enum.at(x, 3)
      |> Floki.find(".MatchCard")
      |> Enum.at(0)
      |> elem(2)
      |> Enum.filter(fn(y) -> is_tuple(y) end)
      |> Enum.filter(fn(z) -> elem(z, 0) == "a" end)
      |> length == 2 end)
   end

   def save_matches_to_database([_, {_, _, [date]}, _, matchcard, _]) do
     matchcard = Floki.find(matchcard, ".MatchCard") |> Enum.at(0) |> elem(2)

    {_, _, [winner]} = Enum.at(matchcard, 0)
    {_, _, [loser]} = Enum.at(matchcard, 2)

    Stats.create_matches(%{"winner" => winner, "winner_elo" => 0, "loser" => loser, "loser_elo" => 0, "date" => date})
   end

end
