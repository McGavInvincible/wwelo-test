defmodule EloCalculator do

  @match_weight 32

  import Ecto.Query

  alias WweloTest.Repo
  alias WweloTest.Stats
  alias WweloTest.Stats.Matches
  alias WweloTest.Stats.Wrestler

  def update_elos do
    list_of_ids_of_new_matches()
    |> Enum.each(fn(x) -> update_match_and_wrestler_elo(x) end)
  end

  def elo_calculator(winner_elo, loser_elo) do
    rwinner = Math.pow(10,(winner_elo/400))
    rloser = Math.pow(10,(loser_elo/400))

    ewinner = rwinner/(rwinner+rloser)
    eloser = rloser/(rwinner+rloser)

    updated_winner_elo = winner_elo + @match_weight*(1-ewinner)
    updated_loser_elo = loser_elo + @match_weight*(-eloser)

    %{winner_elo: round(updated_winner_elo), loser_elo: round(updated_loser_elo)}
  end

  def list_of_ids_of_new_matches do
    new_matches_query = from m in Matches,
      where: is_nil(m.winner_elo) and is_nil(m.loser_elo),
      order_by: [asc: m.date],
      select: m.id

    Repo.all(new_matches_query)
  end

  def update_match_and_wrestler_elo(match_id) do
    current_match = Repo.get_by(Matches, id: match_id)
    winner = Repo.get_by(Wrestler, name: current_match.winner)
    loser = Repo.get_by(Wrestler, name: current_match.loser)

    new_elos = elo_calculator(winner.current_elo, loser.current_elo)
    Stats.update_wrestler(winner, %{"current_elo" => new_elos.winner_elo})
    Stats.update_wrestler(loser, %{"current_elo" => new_elos.loser_elo})
    Stats.update_matches(current_match, %{"winner_elo" => new_elos.winner_elo, "loser_elo" => new_elos.loser_elo})
  end
end
