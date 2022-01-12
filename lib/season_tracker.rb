require './lib/data_collector'
require './lib/calculator'

class SeasonTracker < Statistics
  include DataCollector

  def best_worst_coach(season_id, outcome)
    seasons = @games.find_all {|game| game.season == season_id}
    season_coaches = find_games(@game_teams, seasons)
    coaches = group_by_data_hash(season_coaches, 'head_coach')
    coach_hash = coaches.transform_values do |games|
      results = games.select {|game| game.result == "WIN"} if outcome == 'best'
      results = games.select {|game| game.result != "WIN"} if outcome == 'worst'
      results.length.to_f / games.length
    end
    coach_hash.key(coach_hash.values.max)
  end

  def accurate_team(season_id, outcome)
    seasons = @games.find_all {|game| game.season == season_id}
    season_accuracy = find_games(@game_teams, seasons)
    accuracy_hash = group_by_data_hash(season_accuracy, 'team_id')
    goals_per_game = accuracy_hash.transform_values do |games|
      shots = games.reduce(0) {|sum, game| sum + game.shots}
      goals = games.reduce(0) {|sum, game| sum + game.goals}
      goals.to_f / shots
    end
    outcome == 'most' ? find_name_by_ID(goals_per_game.key(goals_per_game.values.max))[0].team_name :
      find_name_by_ID(goals_per_game.key(goals_per_game.values.min))[0].team_name
  end

  def tackle_results(season_id, outcome)
    seasons = @games.find_all {|game| game.season == season_id}
    season_tackles = find_games(@game_teams, seasons)
    season_tackle_hash = group_by_data_hash(season_tackles, 'team_id')
    tackle_count_hash = season_tackle_hash.transform_values do |games|
      tackles = games.reduce(0) {|sum, game| sum + game.tackles}
    end
    outcome == 'most' ? find_name_by_ID(tackle_count_hash.key(tackle_count_hash.values.max))[0].team_name :
      find_name_by_ID(tackle_count_hash.key(tackle_count_hash.values.min))[0].team_name
  end
end 
