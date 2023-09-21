class Seasons

  def initialize(game_team_data, team_data, games_data)
    @game_team_data = game_team_data
    @team_data = team_data
    @games_data = games_data
  end

  def most_tackles(season)
    game_ids = []
    @games_data.each do |row|
      game_ids << row[:game_id] if row[:season] == season
    end
    game_ids
   
    season_game_team_data = []
    @game_team_data.each do |row|
     season_game_team_data << row if game_ids.include?(row[:game_id]) 
    end

    season_game_team_data
  
    tackles_by_team = Hash.new(0)
    season_game_team_data.each do |row|
      tackles_by_team[row[:team_id]] += row[:tackles].to_i   
    end

    top_team_tackles = tackles_by_team.max_by{ |k, v| v}
  
    top_tackle_team = @team_data.find do |row|
      top_team_tackles.first == row[:team_id]
    end

    top_tackle_team[:team_name]
  end 

  def fewest_tackles(season)
    game_ids = []
    @games_data.each do |row|
      game_ids << row[:game_id] if row[:season] == season
    end
    game_ids
   
    season_game_team_data = []
    @game_team_data.each do |row|
     season_game_team_data << row if game_ids.include?(row[:game_id]) 
    end

    season_game_team_data
  
    tackles_by_team = Hash.new(0)
    season_game_team_data.each do |row|
      tackles_by_team[row[:team_id]] += row[:tackles].to_i   
    end

    least_team_tackles = tackles_by_team.min_by{ |k, v| v}
  
    least_tackle_team = @team_data.find do |row|
      least_team_tackles.first == row[:team_id]
    end

    least_tackle_team[:team_name]
  end 
end