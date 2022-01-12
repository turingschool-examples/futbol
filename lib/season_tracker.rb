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
  
  def most_tackles(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    season_tackles = []
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        season_tackles << game_2 if game.game_id == game_2.game_id
      end
    end
    teams = season_tackles.group_by do |game|
      game.team_id
    end
    hash = Hash.new
    teams.each_pair do |team, games|
      tackles = games.reduce(0) do |sum, game|
        sum + game.tackles
      end
      hash[team] = tackles
    end
    find_name_by_ID(hash.key(hash.values.max))[0].team_name
  end

  def fewest_tackles(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    season_tackles = []
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        season_tackles << game_2 if game.game_id == game_2.game_id
      end
    end
    teams = season_tackles.group_by do |game|
      game.team_id
    end
    hash = Hash.new
    teams.each_pair do |team, games|
      tackles = games.reduce(0) do |sum, game|
        sum + game.tackles
      end
      hash[team] = tackles
    end
    find_name_by_ID(hash.key(hash.values.min))[0].team_name
  end
end
