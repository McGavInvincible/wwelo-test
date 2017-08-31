defmodule DatabaseScraper do

  def list_of_matches do
    response=HTTPoison.get!("https://www.cagematch.net/?id=112&view=search&sEventType=TV-Show|Pay%20Per%20View&sDateFromDay=01&sDateFromMonth=01&sDateFromYear=2017&sDateTillDay=31&sDateTillMonth=12&sDateTillYear=2017&sPromotion=1&sWorkerRelationship=Any&s=0")

    singles_matches = Floki.parse(response.body)
                        |> Floki.find(".TBase")
                        |> Floki.find(".MatchCard")
                        |> Enum.filter(fn(x) -> elem(x,2)
                        |> Enum.filter(fn(y) -> is_tuple(y) end)
                        |> Enum.filter(fn(z) -> elem(z,0) == "a" end)
                        |> length == 2 end)

    dates_and_showtypes = Floki.parse(response.body)
                            |> Floki.find(".TBase")
                            |> Floki.find(".TCol")
                            |> Floki.find(".TColSeparator")
                            |> Enum.filter(fn(x) -> elem(x,2)
                            |> Enum.at(0)
                            |> is_tuple == false end)
                            |> Enum.map(fn(x) -> elem(x,2)
                            |> Enum.at(0) end)

    dates = Enum.filter(dates_and_showtypes, fn(x) -> String.contains?(x, ".") end)
    showtypes = Enum.filter(dates_and_showtypes, fn(x) -> String.contains?(x, ".") == false end)

    singles_matches

   end
end
