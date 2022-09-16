require 'csv'
require 'pry'

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
  
#-----------------------------------Game Statistics-----------------------------------
   # Origional method from Iteration 2
  def highest_total_score
    highest_scoring_game = @games.max_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    highest_scoring_game[:away_goals].to_i + highest_scoring_game[:home_goals].to_i
  end

  # Origional method from Iteration 2
  def lowest_total_score
    lowest_scoring_game = @games.min_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    lowest_scoring_game[:away_goals].to_i + lowest_scoring_game[:home_goals].to_i
  end

  # Helper method used in percentage_ties & percentage_home_wins & percentage_visitor_wins
  # Recommend refactor?
  def total_games
    @games.count
  end

  # Origional method from Iteration 2
  # Recommend combining percentage_ties, percentage_home_wins, percentage_visitor_wins methods using mixins or ?
  def percentage_home_wins
    home_wins = 0
   @games.each do |row|
      if row[:away_goals] < row[:home_goals]
        home_wins += 1
      end
    end
    (home_wins.to_f / @games.count).round(2)
  end

  # Origional method from Iteration 2
  # Recommend combining percentage_ties, percentage_home_wins, percentage_visitor_wins methods using mixins or ?
  def percentage_visitor_wins
    visitor_wins = 0
   @games.each do |row|
      if row[:away_goals] > row[:home_goals]
        visitor_wins += 1
      end
    end
    (visitor_wins.to_f / @games.count).round(2)
  end

  # Origional method from Iteration 2
  # Recommend combining percentage_ties, percentage_home_wins, percentage_visitor_wins methods using mixins or ?
  def percentage_ties
    ties = 0
    @games.each do |row|
      if [row[:away_goals]] == [row[:home_goals]]
       ties += 1
      end
    end
    (ties.to_f / @games.count).round(2)
  end
  
  # Origional method from Iteration 2
  def count_of_games_by_season
    @games[:season].tally
  end

  # Origional method from Iteration 2
  def average_goals_per_game
    total_goals = @games[:away_goals].map(&:to_i).sum.to_f + @games[:home_goals].map(&:to_i).sum
    (total_goals / @games.size).round(2)
  end

  # Origional method from Iteration 2
  def average_goals_by_season
    season_goal_averages = Hash.new(0)
  end

#-----------------------------------League Statistics-----------------------------------
  #Original method from iteration 2
  def count_of_teams
    @teams.length
  end

  # Original method from iteration 2
  # Could refactor and split up into several helper methods
  def best_offense
    hash = {}
    # Create a hash representing each team containing a hash with each team's total games and goals
    @game_teams.each do |row|
      if hash[row[:team_id]] == nil
        hash[row[:team_id]] = {games: 1, goals: row[:goals].to_i}
      else
        hash[row[:team_id]][:games] += 1
        hash[row[:team_id]][:goals] += row[:goals].to_i
      end
    end

    # Create a hash with each team and their avg goals per game
    @avg_goals_per_game = hash.map do |team_id, games_goals_hash|
      [team_id, (games_goals_hash[:goals].to_f/games_goals_hash[:games])]
    end

    # Find the team_id and name of the team w/ highest avg goals
    best_offense_id = @avg_goals_per_game.max_by {|team_id, avg_goals| avg_goals}[0]
    @teams.find {|team| team[:team_id] == best_offense_id}[:teamname]
  end

  #Original method from iteration 2
  def worst_offense
    #uses @avg_goals_per_game hash from best_offense
    worst_offense_id = @avg_goals_per_game.min_by {|team_id, avg_goals| avg_goals}[0]
    @teams.find {|team| team[:team_id] == worst_offense_id}[:teamname]
  end

  # Helper method is used in average_scores_for_all_visitors & average_scores_for_all_home_teams
  # Recomend refactor by mixin 'calculator'
  def average_score_per_game(game_teams_selection)
    goals = game_teams_selection.sum {|game| game[:goals].to_f}
    # You need to / 2. The game_teams CSV has 2 lines to represent one game.
    games = (game_teams_selection.length.to_f/2.0)
    goals / games
  end

  # Helper method is used in average_scores_for_all_visitors
  def away_games_by_team_id
    away_games_list = @game_teams.find_all {|game| game[:hoa] == "away"}
    away_games_hash = Hash.new([])
    away_games_list.each do |game|
      away_games_hash[game[:team_id].to_i] += [game]
    end
    away_games_hash
  end

  # Helper method is used in used in average_scores_for_all_home_teams
  def home_games_by_team_id
    home_games_list = @game_teams.find_all {|game| game[:hoa] == "home"}
    home_games_hash = Hash.new([])
    home_games_list.each do |game|
      home_games_hash[game[:team_id].to_i] += [game]
    end
    home_games_hash
  end

  # Helper method is used in highest_scoring_visitor & lowest_scoring_visitor
  def average_scores_for_all_visitors
    @visitor_hash = {}
    away_games_by_team_id.each do |team_id, games_array|
      @visitor_hash[team_id] = average_score_per_game(games_array)
    end
    @visitor_hash
  end

  # Helper method is used in highest_scoring_home_team & lowest_scoring_home_team
  def average_scores_for_all_home_teams
    @home_hash = {}
    home_games_by_team_id.each do |team_id, games_array|
      @home_hash[team_id] = average_score_per_game(games_array)
    end
    @home_hash
  end

  # Origional method from Iteration 2
  def highest_scoring_visitor
    average_scores_for_all_visitors
    highest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @visitor_hash.key(@visitor_hash.values.max)
    end
    highest_scoring_team[:teamname]
  end

  # Origional method from Iteration 2
  def highest_scoring_home_team
    average_scores_for_all_home_teams
    highest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @home_hash.key(@home_hash.values.max)
    end
    highest_scoring_team[:teamname]
  end

  # Origional method from Iteration 2
  def lowest_scoring_visitor
    average_scores_for_all_visitors
    lowest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @visitor_hash.key(@visitor_hash.values.min)
    end
    lowest_scoring_team[:teamname]
  end

  # Origional method from Iteration 2
  def lowest_scoring_home_team
    average_scores_for_all_home_teams
    highest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @home_hash.key(@home_hash.values.min)
    end
    highest_scoring_team[:teamname]
  end
end
