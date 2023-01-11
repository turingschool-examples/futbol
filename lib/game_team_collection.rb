require_relative '../lib/game_team'

module GameTeamCollection

  def add_total_score_and_games(game_team_collection, teams_total_scores, teams_total_games)
    # find_average(@game_teams_array, teams_total_scores, teams_total_games, team_id, goals)

    game_team_collection.each do |game_team|
      teams_total_scores[game_team.team_id] += game_team.goals.to_f
      teams_total_games[game_team.team_id] += 1.0
    end
  end
end