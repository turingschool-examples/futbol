require './lib/data_collector'

class GameTeamTracker < Statistics
  include DataCollector
  def count_of_teams
    unique = @game_teams.map {|game|game.team_id}
    unique.uniq.count
  end

  def offense(best_worse)
    game_array = sort_games(@game_teams)
    team_hash = goal_counter(game_array)
    best_or_worse(best_worse, team_hash)
  end

  def scoring_visitor(best_worse)
    home_away = @game_teams.find_all { |game| game.hoa == "away"}
    home_team_hash = group_by_data_hash(home_away, "team_id")
    team_hash = goal_counter(home_team_hash)
    result = best_or_worse(best_worse, team_hash)
  end

  def home_scoring(best_worse)
    home_away = @game_teams.find_all { |game| game.hoa == "home"}
    home_team_hash = group_by_data_hash(home_away, "team_id")
    team_hash = goal_counter(home_team_hash)
    result = best_or_worse(best_worse, team_hash)
  end
end
