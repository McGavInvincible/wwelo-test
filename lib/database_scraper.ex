defmodule DatabaseScraper do

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

    dates = Enum.map(singles_table_contents, fn(x) -> Enum.at(x, 1) |> elem(2) |> Enum.at(0) end)

    matchcards = Enum.map(singles_table_contents, fn(x) -> Floki.find(x, ".MatchCard") end)

    winners = Enum.map(matchcards, fn(x) -> Enum.at(x, 0) |> elem(2) |> Enum.at(0) |> elem(2) |> Enum.at(0) end)
    losers = Enum.map(matchcards, fn(x) -> Enum.at(x, 0) |> elem(2) |> Enum.at(2) |> elem(2) |> Enum.at(0) end)

    singles_table_contents
   end

   def save_matches_to_database([_, {_, _, [date]}, _, matchcard, _]) do
     matchcard = Floki.find(matchcard, ".MatchCard") |> Enum.at(0) |> elem(2)

    {_, _, [winner]} = Enum.at(matchcard, 0)
    {_, _, [loser]} = Enum.at(matchcard, 2)

    {winner, loser, date}
   end

end
