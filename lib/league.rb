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

  #this method is not DRY. It has same functionality as def total_games
  def team_total_games
    team_and_games = Hash.new(0)
    @game_team_data.each do |game|
      team_id = game[:team_id]
      team_and_games[team_id] += 1
    end
    team_and_games
  end

  def team_total_goals
    team_and_goals = Hash.new(0)
    @game_team_data.each do |game|
      team_id = game[:team_id]
      goals = game[:goals].to_i
      team_and_goals[team_id] += goals
    end
    team_and_goals
  end

  def best_offense
    goals_per_game = Hash.new(0)

    team_total_games.each do |team_id, games|
      goals = team_total_goals[team_id]
      gpg = (goals.to_f / games.to_f)
      goals_per_game[team_id] = gpg
    end
    best_team_id = goals_per_game.max_by { |team_id, gpg| gpg }

    @team_data.each do |team|
      if team[:team_id] == best_team_id[0]
        return team[:team_name]
      end
    end
  end

  def worst_offense
    goals_per_game = Hash.new(0)

    team_total_games.each do |team_id, games|
      goals = team_total_goals[team_id]
      gpg = (goals.to_f / games.to_f)
      goals_per_game[team_id] = gpg
    end
    worst_team_id = goals_per_game.min_by { |team_id, gpg| gpg }

    @team_data.each do |team|
      if team[:team_id] == worst_team_id[0]
        return team[:team_name]
      end
    end
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
  def total_games
    visitor_games = Hash.new(0)
    @game_team_data.each do |game|
      team_id = game[:team_id]
      visitor_games[team_id] += 1
    end
    visitor_games
  end

  # calculate average goals per game
  def ave_visitor_goals
    ave_visitor_goals = Hash.new(0)
    visitor_goals.each do |team_id, goals|
      average = (goals.to_f / total_games[team_id])
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

  def highest_scoring_visitor
    highest_scoring_name = ""
    @team_data.each do |team|
      if highest_ave_visitor_goals[0] == team[:team_id]
        highest_scoring_name += team[:team_name]
      end
    end
    highest_scoring_name
  end

  # determine lowest average, put team id and ave in an array
  def lowest_ave_visitor_goals
    lowest_ave_id = ave_visitor_goals.min_by do |team_id, goals|
      goals
    end
    lowest_ave_id
  end

  def lowest_scoring_visitor
    lowest_scoring_name = ""
    @team_data.each do |team|
      if lowest_ave_visitor_goals[0] == team[:team_id]
        lowest_scoring_name += team[:team_name]
      end
    end
    lowest_scoring_name
  end

  # count total home goals per team
  def home_goals
    home_goals = Hash.new(0)
    @game_team_data.each do |game|
      home_or_away = game[:hoa]
      goals = game[:goals].to_i
      team_id = game[:team_id]
      if home_or_away == "home"
        home_goals[team_id] += goals
      end
    end
    home_goals
  end

  # calculate average goals per game
  def ave_home_goals
    ave_home_goals = Hash.new(0)
    home_goals.each do |team_id, goals|
      average = (goals.to_f / total_games[team_id])
      ave_home_goals[team_id] = average
    end
    ave_home_goals
  end

  # determine highest average, put team id and ave in an array
  def highest_ave_home_goals
    highest_ave_id = ave_home_goals.max_by do |team_id, goals|
      goals
    end
    highest_ave_id
  end

  def highest_scoring_home_team
    highest_scoring_name = ""
    @team_data.each do |team|
      if highest_ave_home_goals[0] == team[:team_id]
        highest_scoring_name += team[:team_name]
      end
    end
    highest_scoring_name
  end
end

