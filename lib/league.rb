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
    # calc average score for each team's away goals, store in hash with team_id => ave_score

    # count total goals per game
    # this could potentially be a helper method
    visitor_goals = Hash.new(0)
    @game_team_data.each do |game|
      home_or_away = game[:hoa]
      goals = game[:goals].to_i
      team_id = game[:team_id]
      if home_or_away == "away"
        visitor_goals[team_id] += goals
      end
    end

    # count total games per team
    

    # determine highest average
    # this could potentially be a helper method
    highest_scoring_id = visitor_goals.max_by do |team_id, goals|
      goals
    end

    # link team_id to team_name
    # this could potentially be a helper method
    highest_scoring_name = ""
    @team_data.each do |team|
      if highest_scoring_id[0] == team[:team_id]
        highest_scoring_name += team[:team_name]
      end
    end
    highest_scoring_name
  end
end
