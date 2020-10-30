require_relative './game_team'

class GameTeamsCollection
  attr_reader :game_teams
  def initialize(game_teams_path, parent)
    @parent = parent
    @game_teams = create_game_teams(game_teams_path)
  end

  def create_game_teams(game_teams_path)
    csv = CSV.read(game_teams_path, headers: true, header_converters: :symbol)
    csv.map do |row|
      GameTeam.new(row, self)
    end
  end

  def find_by_id(id)
    @parent.find_by_id(id)
  end

  def games_by_team
    total_games = Hash.new(0)
    game_teams.each do |game_team|
      total_games[game_team.team_id] += 1
    end
    total_games
  end

  def away_games_by_team
    away_games = Hash.new(0)
    game_teams.each do |game_team|
      if game_team.hoa == "away"
        away_games[game_team.team_id] += 1
      end
    end
    away_games
  end

  def home_games_by_team
    home_games = Hash.new(0)
    game_teams.each do |game_team|
      if game_team.hoa == "home"
        home_games[game_team.team_id] += 1
      end
    end
    home_games
  end

  def average_goals_by_team
    average = Hash.new(0)
    game_teams.each do |game_team|
      average[game_team.team_id] += game_team.goals
    end
    games_by_team.merge(average) do |key, games, goals|
      (goals.to_f / games).round(2)
    end
  end

  def average_away_goals_by_team
    average = Hash.new(0)
    game_teams.each do |game_team|
      if game_team.hoa == "away"
        average[game_team.team_id] += game_team.goals
      end
    end
    away_games_by_team.merge(average) do |key, games, goals|
      (goals.to_f / games).round(2)
    end
  end

  def average_home_goals_by_team
    average = Hash.new(0)
    game_teams.each do |game_team|
      if game_team.hoa == "home"
        average[game_team.team_id] += game_team.goals
      end
    end
    home_games_by_team.merge(average) do |key, games, goals|
      (goals.to_f / games).round(2)
    end
  end

  def best_offense
    max_goals = average_goals_by_team.max_by do |goals|
      goals[-1]
    end
    find_by_id(max_goals[0])
  end

  def worst_offense
    min_goals = average_goals_by_team.min_by do |goals|
      goals[-1]
    end
    find_by_id(min_goals[0])
  end

  def highest_scoring_visitor
    highest_goals = average_away_goals_by_team.max_by do |goals|
      goals[-1]
    end
    find_by_id(highest_goals[0])
  end

  def highest_scoring_hometeam
    highest_goals = average_home_goals_by_team.max_by do |goals|
      goals[-1]
    end
    find_by_id(highest_goals[0])
  end

  def lowest_scoring_visitor
    lowest_goals = average_away_goals_by_team.min_by do |goals|
      goals[-1]
    end
    find_by_id(lowest_goals[0])
  end

  def lowest_scoring_hometeam
    lowest_goals = average_home_goals_by_team.min_by do |goals|
      goals[-1]
    end
    find_by_id(lowest_goals[0])
  end
end
