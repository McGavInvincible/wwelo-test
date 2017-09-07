defmodule EloCalculator do

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

end
