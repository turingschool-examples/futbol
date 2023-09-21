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

  # def worst_offense

  # end
end
