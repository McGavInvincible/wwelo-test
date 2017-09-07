defmodule EloCalculator do

  import Ecto.Query

  alias WweloTest.Repo
  alias WweloTest.Stats.Matches

  def elo_calculator(winner_elo, loser_elo) do
    rwinner = Math.pow(10,(winner_elo/400))
    rloser = Math.pow(10,(loser_elo/400))

    ewinner = rwinner/(rwinner+rloser)
    eloser = rloser/(rwinner+rloser)

    match_weight = 32

    updated_winner_elo = winner_elo + match_weight*(1-ewinner)
    updated_loser_elo = loser_elo + match_weight*(-eloser)

    %{winner_elo: Float.round(updated_winner_elo), loser_elo: Float.round(updated_loser_elo)}
  end

  def list_of_ids_of_new_matches do
    new_matches_query = from m in Matches,
      where: is_nil(m.winner_elo) and is_nil(m.loser_elo),
      order_by: [asc: m.date],
      select: m.id

    Repo.all(new_matches_query)
  end

end
