class Season
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def winningest_coach(season)  #stat_tracker method
    wins = games_in_season(season).select do |game|
      game if game[:result] == "WIN"
    end
    coach_wins_hash = Hash.new(0.0)
    wins.each do |game|
      coach_wins_hash[game[:head_coach]] += 1.0
    end
    games_coached = Hash.new(0.0)
    games_in_season(season).each do |game|
      games_coached[game[:head_coach]] += 1.0
    end
    coach_wins_hash.each_key do |key|
      coach_wins_hash[key] = coach_wins_hash[key] / games_coached[key]
    end
    coach_wins_hash.key(coach_wins_hash.values.max)
  end

  def worst_coach(season) #stat_tracker method
    loss = games_in_season(season).select do |game|
      game if game[:result] == "LOSS"
    end
    coach_loss_hash = Hash.new(0.0)
    loss.each do |game|
      coach_loss_hash[game[:head_coach]] += 1.0
    end
    games_coached = Hash.new(0.0)
    games_in_season(season).each do |game|
      games_coached[game[:head_coach]] += 1.0
    end
    coach_loss_hash.each_key do |key|
      coach_loss_hash[key] = coach_loss_hash[key] / games_coached[key]
    end
    coach_loss_hash.key(coach_loss_hash.values.max)
  end

  def games_in_season(season) #helper method
    #array of games from game_teams that have a matching game_id to the game_ids within a certain season
    season_games = @games.select do |game|
      game if game[:season].to_i == season
    end
    game_ids = season_games.map do |game|
      game[:game_id]
    end
    games = @game_teams.select do |game|
     game if game_ids.include?(game[:game_id])
    end
  end

  def most_accurate_team(season)  #stat_tracker method
    # Name of the Team with the best ratio of shots to goals for the season
    # goals / shots
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

  end

  def games_in_season_by_team_id(season) #helper method
    #returns a hash with team_id as key / array of games as values
    games_in_season(season).group_by {|game| game[:team_id]}
  end

  def total_goals_per_season(season) #helper method
    #return a hash with team_id as key / total goals as float values
    goals_per_team = Hash.new(0)
    games_in_season_by_team_id(season).each do |team_id, game_array|
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
    games_in_season_by_team_id(season).each do |team_id, game_array|
      shots_per_team[team_id] = game_array.map {|game| game[:shots].to_f}
    end
    shots_per_team.each do |team_id, shots_array|
      shots_per_team[team_id] = shots_array.sum
    end
    shots_per_team
  end


  def most_tackles(season)  #stat_tracker method

  end

  def fewest_tackles(season) #stat_tracker method

  end
end
