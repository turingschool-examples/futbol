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

  # count total visitor goals per team
  def visitor_goals
    visitor_goals = Hash.new(0)
    @game_team_data.each do |game|
      home_or_away = game[:hoa]
      goals = game[:goals].to_i
      team_id = game[:team_id]
      if home_or_away == "away"
        visitor_goals[team_id] += goals
      end
    end
    visitor_goals
  end

  # count total visitor games per team
  def visitor_games
    visitor_games = Hash.new(0)
    @game_team_data.each do |game|
      team_id = game[:team_id]
      visitor_games[team_id] += 1
    end
    visitor_games
  end

  # calculate average goals per game
  # this is broken
  def ave_visitor_goals
    ave_visitor_goals = Hash.new(0)
    visitor_goals.each do |team_id, goals|
      total_games = visitor_games[team_id]
      average = (goals.to_f / total_games)
      ave_visitor_goals[team_id] = average
    end
    ave_visitor_goals
  end

  # determine highest average, put team id and ave in an array
  def highest_ave_visitor_goals
    highest_ave_id = ave_visitor_goals.max_by do |team_id, goals|
      goals
    end
    highest_ave_id
  end

  # link team_id to team_name
  def highest_scoring_visitor
    highest_scoring_name = ""
    @team_data.each do |team|
      if highest_ave_visitor_goals[0] == team[:team_id]
        highest_scoring_name += team[:team_name]
      end
    end
    highest_scoring_name
  end

  def lowest_ave_visitor_goals
    lowest_ave_id = ave_visitor_goals.min_by do |team_id, goals|
      goals
    end
    lowest_ave_id
  end
end
