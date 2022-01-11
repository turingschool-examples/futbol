class Season
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def winningest_coach(season)  #stat_tracker method
    win_percentage_by_coach(season).key(win_percentage_by_coach(season).values.max)
  end

  def worst_coach(season) #stat_tracker method
    win_percentage_by_coach(season).key(win_percentage_by_coach(season).values.min)
  end

  def win_percentage_by_coach(season)#helper method
    wins = games_in_season_by_datatype(season, :head_coach).transform_values do |values|
      values.reject do |game|
        game if game[:result] != "WIN"
      end
    end
    win_percentage_by_coach = wins.transform_values do |win_games|
      win_games.count.to_f / games_in_season(season).count.to_f
    end
  end

  def games_in_season(season) #helper method
    #array of games from game_teams that have a matching game_id to the game_ids within a certain season
    season_games = @games.select do |game|
      game if game[:season] == season
    end
    game_ids = season_games.map do |game|
      game[:game_id]
    end
    games = @game_teams.select do |game|
      game if game_ids.include?(game[:game_id])
    end

  end

  def games_in_season_by_datatype(season, datatype) #helper method
    #returns a hash with datatype as key / array of games as values
    games_in_season(season).group_by {|game| game[datatype]}
  end

  def most_accurate_team(season)  #stat_tracker method
    # Name of the Team with the best ratio of shots to goals for the season
    shot_accuracy_hash = Hash.new(0.0)
    total_shots_per_season(season).each_key do |key|
      shot_accuracy_hash[key] = total_goals_per_season(season)[key] / total_shots_per_season(season)[key]
    end
    team_info = @teams.find do |team|
      team[:team_id] == shot_accuracy_hash.key(shot_accuracy_hash.values.max) #this yeilds  string of the team_id
    end
    team_info[:teamname]
  end

  def least_accurate_team(season)  #stat_tracker method
    # Name of the Team with the worst ratio of shots to goals for the season
    shot_accuracy_hash = Hash.new(0.0)
    total_shots_per_season(season).each_key do |key|
      shot_accuracy_hash[key] = total_goals_per_season(season)[key] / total_shots_per_season(season)[key]
    end
    team_info = @teams.find do |team|
      team[:team_id] == shot_accuracy_hash.key(shot_accuracy_hash.values.min) #this yeilds  string of the team_id
    end
    team_info[:teamname]
  end

  def total_goals_per_season(season) #helper method
    #return a hash with team_id as key / total goals as float values
    goals_per_team = Hash.new(0)
    games_in_season_by_datatype(season, :team_id).each do |team_id, game_array|
      goals_per_team[team_id] = game_array.map {|game| game[:goals].to_f}
    end
    goals_per_team.each do |team_id, goals_array|
      goals_per_team[team_id] = goals_array.sum
    end
    goals_per_team
  end

  def total_shots_per_season(season) #helper method
    #return a hash with team_id as key / total shots as float values
    shots_per_team = Hash.new(0)
    games_in_season_by_datatype(season, :team_id).each do |team_id, game_array|
      shots_per_team[team_id] = game_array.map {|game| game[:shots].to_f}
    end
    shots_per_team.each do |team_id, shots_array|
      shots_per_team[team_id] = shots_array.sum
    end
    shots_per_team
  end

  def most_tackles(season)  #stat_tracker method
    tackles_hash = Hash.new(0.0)
    tackles_per_season(season).each_key do |key|
      tackles_hash[key] = tackles_per_season(season)[key]
    end
    team_info = @teams.find do |team|
      team[:team_id] == tackles_hash.key(tackles_hash.values.max) #this yeilds  string of the team_id
    end
    team_info[:teamname]
  end

  def fewest_tackles(season) #stat_tracker method
    tackles_hash = Hash.new(0.0)
    tackles_per_season(season).each_key do |key|
      tackles_hash[key] = tackles_per_season(season)[key]
    end
    team_info = @teams.find do |team|
      team[:team_id] == tackles_hash.key(tackles_hash.values.min) #this yeilds  string of the team_id
    end
    team_info[:teamname]
  end

  def tackles_per_season(season) #helper method
    tackles_per_team = Hash.new(0)
    games_in_season_by_datatype(season, :team_id).each do |team_id, game_array|
      tackles_per_team[team_id] = game_array.map {|game| game[:tackles].to_f}
    end
    tackles_per_team.each do |team_id, tackles_array|
      tackles_per_team[team_id] = tackles_array.sum
    end
    tackles_per_team
  end
end
