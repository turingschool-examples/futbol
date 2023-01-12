require_relative '../lib/game_team'

module GameTeamCollection

  def add_total_score_and_games(game_team_collection, teams_total_scores, teams_total_games)
    game_team_collection.each do |game_team|
      teams_total_scores[game_team.team_id] += game_team.goals.to_f
      teams_total_games[game_team.team_id] += 1.0
    end
  end

  def game_teams_by_team_ids(game_team_collection)
    @game_teams_by_team_ids ||= game_team_collection.group_by do |game|
      game.team_id
    end
  end
end