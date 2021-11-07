require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'calculator'

class StatTracker
  include Calculator
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

   # Game Statistics

  def highest_total_score
    @games.map {|game| game.total_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.total_goals}.min
  end

  def total_games_count
    @games.length.to_f
  end

  def home_wins_count
    @games.select {|game| game.home_win?}.length.to_f
  end

  def percentage_home_wins
    percentage(home_wins_count, total_games_count)
  end

  def visitor_wins_count
    @games.select {|game| game.visitor_win?}.length.to_f
  end

  def percentage_visitor_wins
    percentage(visitor_wins_count, total_games_count)
  end

  def tied_games_count
    @games.select {|game| game.tie_game?}.length.to_f
  end

  def percentage_ties
    percentage(tied_games_count, total_games_count)
  end

  # def total_goals
  #   total_goals_count = 0.0
  #   @games.each do |game|
  #     total_goals_count += game.total_goals
  #   end
  #   total_goals_count
  # end

  def average_goals_across_all_games #refactor league stats average_goals_per_game to different name and rename this
    all_total_goals = @games.map {|game| game.total_goals}
    average(all_total_goals)
  end

  def get_season_ids
    @games.map do |game|
      game.season
    end
  end

  def filter_by_season(season_id)
    #create array of all items with season_id
    filtered_seasons = []

    @games.each do |game|
      if season_id == game.season
        filtered_seasons << game
      end
    end
    filtered_seasons
  end

  def count_of_games_by_season
    season_game_count = {}

    get_season_ids.uniq.each do |season_id|
      season_game_count[season_id] = filter_by_season(season_id).length.to_f
    end
    season_game_count
  end

  def average_goals_by_season
    average_goals_by_season = {}
    get_season_ids.uniq.each do |season_id|
      season_goal_count = 0

      season_games = filter_by_season(season_id)

      season_games.each do |game|
          season_goal_count += game.total_goals
      end

      average_goals = season_goal_count.to_f / season_games.length.to_f

      average_goals_by_season[season_id] = average_goals.round(2)
    end
    average_goals_by_season
  end

  # League Statistics

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

  def lowest_scoring_home_team
    id = @game_teams.min_by do |game|
      average_home_score(game.team_id)
    end.team_id

    @teams.find do |team|
      id == team.team_id
    end.team_name
  end
end
