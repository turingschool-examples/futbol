class TeamManager
  attr_reader :team_data,
              :tracker

  def initialize(location, tracker)
    @team_data = teams_stats(location)
    @tracker = tracker
  end

  def teams_stats(location)
    teams_data = CSV.read(location, { encoding: 'UTF-8', headers: true, header_converters: :symbol, converters: :all })
    result = []
    teams_data.each do |team|
      team.delete(:stadium)
      result << Team.new(team, self)
    end
    result
  end

  def count_of_teams
    @team_data.length
  end

  def group_by_team_id
    @tracker.game_teams_manager.group_by_team_id
  end

  def team_id_and_average_goals
    average_goals_by_team = {}
    group_by_team_id.each do |team, games|
      total_games = games.map { |game| game.game_id }
      total_goals = games.sum { |game| game.goals }
      average_goals_by_team[team] = (total_goals.to_f / total_games.count).round(2)
    end
    average_goals_by_team
  end

  def best_offense
    best_attack = @team_data.find do |team|
      team.teamname if best_offense_stats == team.team_id
    end
    best_attack.teamname
  end

  def worst_offense
    worst_attack = @team_data.find do |team|
      team.teamname if worst_offense_stats == team.team_id
    end
    worst_attack.teamname
  end

  def best_offense_stats
    stats = team_id_and_average_goals.sort_by do |key, value|
      value
    end
    stats[-1][0]
  end

  def worst_offense_stats
    stats = team_id_and_average_goals.sort_by do |key, value|
      value
    end
    stats[0][0]
  end

  def team_id_and_average_away_goals
    away_team_goals = {}
    group_by_team_id.each do |team, games|
      away_games = games.find_all { |game| game.hoa == 'away' }
      away_goals = away_games.sum { |game| game.goals }
      away_team_goals[team] = (away_goals.to_f / away_games.count).round(3)
    end
    away_team_goals
  end

  def team_highest_away_goals
    away_goals = team_id_and_average_away_goals.sort_by do |team, goals|
      goals
    end
    away_goals[-1][0]
  end

  def highest_scoring_visitor
    visitor = @team_data.find do |team|
      team.teamname if team_highest_away_goals == team.team_id
    end
    visitor.teamname
  end

  def team_lowest_away_goals
    away_goals = team_id_and_average_away_goals.sort_by do |team, goals|
      goals
    end
    away_goals[0][0]
  end

  def lowest_scoring_visitor
    visitor = @team_data.find do |team|
      team.teamname if team_lowest_away_goals == team.team_id
    end
    visitor.teamname
  end

  def team_id_and_average_home_goals
    home_team_goals = {}
    group_by_team_id.each do |team, games|
      home_games = games.find_all { |game| game.hoa == 'home' }
      home_goals = home_games.sum { |game| game.goals }
      home_team_goals[team] = (home_goals.to_f / home_games.count).round(3)
    end
    home_team_goals
  end

  def team_highest_home_goals
    home_goals = team_id_and_average_home_goals.sort_by do |team, goals|
      goals
    end
    home_goals[-1][0]
  end

  def highest_scoring_home_team
    home = @team_data.find do |team|
      team.teamname if team_highest_home_goals == team.team_id
    end
    home.teamname
  end

  def team_lowest_home_goals
    home_goals = team_id_and_average_home_goals.sort_by do |team, goals|
      goals
    end
    home_goals[0][0]
  end

  def lowest_scoring_home_team
    home = @team_data.find do |team|
      team.teamname if team_lowest_home_goals == team.team_id
    end
    home.teamname
  end
end
