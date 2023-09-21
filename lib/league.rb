class League 
  # I'm putting all the data in here for total teams. Not sure if this is correct
  def initialize(game_data, team_data, game_team_data)
    @game_data = game_data
    @team_data = team_data
    @game_team_data = game_team_data
  end

  def count_of_teams
    teams = @team_data.map do |row|
      row[:team_name]
    end
    teams.count
  end

  # num games per team
  # total score per team
  # games and scores, total scores and 

  def highest_scoring_visitor
    # Name of the team with the highest average score per game across all seasons when they are away
    # calc average score for each team's away goals, store in hash with team_id => ave_score
    # determine highest average
    # link team_id to team_name
    hash = {}
    @game_data.each do |game|
      
      team_id = game[:team_id] 
    end
  end
end
