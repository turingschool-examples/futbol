class Season 
  attr_reader :games_data,
              :game_teams_data,
              :teams_data
  
  def initialize(games_data, games_teams_data, teams_data)
    @games_data = games_data
    @games_teams_data = games_teams_data
    @teams_data = teams_data
  end

  # creates an array with just all the games from a specific season
  def create_season(season)
    specific_season = []
    @games_teams_data.each do |row|
      specific_season << row if row[:game_id].start_with?(season.to_s[0,4])
    end
    specific_season
  end

  # returns the team name when given the team_id
  def get_team_name(team_id)
    @teams_data.each do |row|
      return row[:teamname] if row[:team_id] == team_id
    end
  end
  # name of the team with the most tackles in the season
  def most_tackles(season)
    team_tackle_totals = Hash.new(0)

    create_season(season).each do |row|
      tackles = row[:tackles].to_i
      team_tackle_totals[row[:team_id]] += tackles
    end
    
    team_most_tackles_id = team_tackle_totals.max_by do |team_id, tackles|
      tackles
    end

    get_team_name(team_most_tackles_id[0])
  end

  # name of the team with the fewest tackles in the season
  def fewest_tackles(season)

  end

  # name of the coach with the worst win percentage for the season
  def worst_coach(season)

  end

end