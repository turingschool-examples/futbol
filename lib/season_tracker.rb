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

  def most_accurate_team(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    season_accuracy = []
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        season_accuracy << game_2 if game.game_id == game_2.game_id
      end
    end
    teams = season_accuracy.group_by do |game|
      game.team_id
    end
    hash = Hash.new
    teams.each_pair do |team, games|
      shots = games.reduce(0) do |sum, game|
        sum + game.shots
      end
      goals = games.reduce(0) do |sum, game|
        sum + game.goals
      end
      hash[team] = goals.to_f / shots
    end
    find_name_by_ID(hash.key(hash.values.max))[0].team_name
  end

  def least_accurate_team(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    season_accuracy = []
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        season_accuracy << game_2 if game.game_id == game_2.game_id
      end
    end
    teams = season_accuracy.group_by do |game|
      game.team_id
    end
    hash = Hash.new
    teams.each_pair do |team, games|
      shots = games.reduce(0) do |sum, game|
        sum + game.shots
      end
      goals = games.reduce(0) do |sum, game|
        sum + game.goals
      end
      hash[team] = goals.to_f / shots
    end
    find_name_by_ID(hash.key(hash.values.min))[0].team_name
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
