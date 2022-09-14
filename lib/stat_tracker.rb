require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(csv_hash)
    games_input = CSV.read(csv_hash[:games], headers: true, header_converters: :symbol)
    teams_input = CSV.read(csv_hash[:teams], headers: true, header_converters: :symbol)
    game_teams_input = CSV.read(csv_hash[:game_teams], headers: true, header_converters: :symbol)
    stats_tracker = StatTracker.new(games_input, teams_input, game_teams_input)
  end

  def highest_total_score
    highest_scoring_game = @games.max_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    highest_scoring_game[:away_goals].to_i + highest_scoring_game[:home_goals].to_i
  end

  def lowest_total_score
    lowest_scoring_game = @games.min_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    lowest_scoring_game[:away_goals].to_i + lowest_scoring_game[:home_goals].to_i
  end

  # recomend move methids like this to a mixin 'calculator'
  def average_score_per_game(game_teams_selection)
    goals = game_teams_selection.sum {|game| game[:goals].to_f}
    # You need to / 2. The game_teams CSV has 2 lines to represent one game.
    games = (game_teams_selection.length.to_f/2.0)
    goals / games
  end

  def away_games
    away_games_list = @game_teams.find_all {|game| game[:hoa] == "away"}
    away_games_hash = Hash.new([])
    away_games_list.each do |game|
      away_games_hash[game[:team_id].to_i] += [game]
    end
    away_games_hash
  end

  def home_games
    home_games_list = @game_teams.find_all {|game| game[:hoa] == "home"}
    home_games_hash = Hash.new([])
    home_games_list.each do |game|
      home_games_hash[game[:team_id].to_i] += [game]
    end
    home_games_hash
  end

  def average_scores_for_all_visitors
    @visitor_hash = {}
    away_games.each do |team_id, games_array|
      @visitor_hash[team_id] = average_score_per_game(games_array)
    end
    @visitor_hash
  end

  def highest_scoring_visitor
    average_scores_for_all_visitors
    highest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @visitor_hash.key(@visitor_hash.values.max)
    end
    highest_scoring_team[:teamname]
  end

  def lowest_scoring_visitor
    average_scores_for_all_visitors
    lowest_scoring_team = @teams.find do |team|
      # require 'pry'; binding.pry
      team[:team_id].to_i == @visitor_hash.key(@visitor_hash.values.min)
    end
    lowest_scoring_team[:teamname]
  end

  def highest_scoring_home_team

  end

  def lowest_scoring_home_team

  end
end