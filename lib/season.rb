class Season 
  attr_reader :games_data,
              :game_teams_data,
              :teams_data
  
  def initialize(games_data, games_teams_data, teams_data)
    @games_data = games_data
    @games_teams_data = games_teams_data
    @teams_data = teams_data
  end

  def create_season(season)
    specific_season = []
    @games_teams_data.each do |row|
      specific_season << row if row[:game_id].start_with?(season.to_s[0,4])
    end
    specific_season
  end

  def get_team_name(team_id)
    @teams_data.each do |row|
      return row[:teamname] if row[:team_id] == team_id
    end
  end

  def most_tackles(season)
    team_tackle_totals = Hash.new(0)

    create_season(season).each do |row|
      team_tackle_totals[row[:team_id]] += row[:tackles].to_i
    end
    
    team_most_tackles_id = team_tackle_totals.max_by do |team_id, tackles|
      tackles
    end

    get_team_name(team_most_tackles_id[0])
  end

end