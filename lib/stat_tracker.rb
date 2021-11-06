require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = []
    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      game = Game.new(row)
      games << game
    end
    teams = []
    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      team = Team.new(row)
      teams << team
    end
    game_teams = []
    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      game_team = GameTeam.new(row)
      game_teams << game_team
    end

    stat_tracker = StatTracker.new(games, teams, game_teams)
  end

  def count_of_teams
    @teams.length
  end

  def best_offense
    id = @game_teams.max_by do |team|
      average_goals_per_game(team.team_id)
    end.team_id

    @teams.find do |team|
      id == team.team_id
    end.team_name
  end

  def games_by_team(team_id)
    @game_teams.select do |game|
      game.team_id == team_id
    end
  end

  def total_goals_by_team(team_id)
    goals = []
    games_by_team(team_id).each do |game|
      goals << game.goals
    end
    goals.sum
  end

  def average_goals_per_game(team_id)
    total_goals_by_team(team_id).to_f / games_by_team(team_id).length.to_f
  end

  def worst_offense
    id = @game_teams.min_by do |team|
      average_goals_per_game(team.team_id)
    end.team_id

    @teams.find do |team|
      id == team.team_id
    end.team_name
  end

  def games_away(team_id)
    games = games_by_team(team_id)
    away = []
    games.each do |game|
      if game.hoa == "away"
        away << game
      end
    end
    away
  end

  def average_away_score(team_id)
    games = games_away(team_id)
    away_scores = games_away(team_id).map do |game|
      game.goals
    end
    avg = away_scores.sum.to_f / games.length.to_f
    avg.round(1)
  end

  def highest_scoring_visitor
    id = @game_teams.max_by do |game|
      average_away_score(game.team_id)
    end.team_id

    @teams.find do |team|
      id == team.team_id
    end.team_name
  end

  def games_home(team_id)
    games = games_by_team(team_id)
    home = []
    games.each do |game|
      if game.hoa == "home"
        home << game
      end
    end
    home
  end

  def average_home_score(team_id)
    games = games_home(team_id)
    home_scores = games_home(team_id).map do |game|
      game.goals
    end
    avg = home_scores.sum.to_f / games.length.to_f
    avg.round(1)
  end

  def highest_scoring_home_team
    id = @game_teams.max_by do |game|
      average_home_score(game.team_id)
    end.team_id

    @teams.find do |team|
      id == team.team_id
    end.team_name
  end

  def lowest_scoring_visitor
    id = @game_teams.min_by do |game|
      average_away_score(game.team_id)
    end.team_id

    @teams.find do |team|
      id == team.team_id
    end.team_name
  end 

end
