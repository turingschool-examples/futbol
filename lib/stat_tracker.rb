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
#------------------------------------Game Statistics------------------------------------
  # Original method from Iteration 2
  def highest_total_score
    highest_scoring_game = @games.max_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    highest_scoring_game[:away_goals].to_i + highest_scoring_game[:home_goals].to_i
  end

  # Original method from Iteration 2
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

  # Original method from Iteration 2
  # Recommend combining percentage_ties, percentage_home_wins, percentage_visitor_wins methods using mixins or (look at count iterator)
  def percentage_home_wins
    home_wins = 0
    @games.each do |row|
      if row[:away_goals] < row[:home_goals]
        home_wins += 1
      end
    end
    (home_wins.to_f / @games.count).round(2)
  end

  # Original method from Iteration 2
  # Recommend combining percentage_ties, percentage_home_wins, percentage_visitor_wins methods using mixins or (look at count iterator)
  def percentage_visitor_wins
    visitor_wins = 0
    @games.each do |row|
      if row[:away_goals] > row[:home_goals]
        visitor_wins += 1
      end
    end
    (visitor_wins.to_f / @games.count).round(2)
  end

  # Original method from Iteration 2
  # Recommend combining percentage_ties, percentage_home_wins, percentage_visitor_wins methods using mixins or (look at count iterator)
  def percentage_ties
    ties = 0
    @games.each do |row|
      if [row[:away_goals]] == [row[:home_goals]]
       ties += 1
      end
    end
    (ties.to_f / @games.count).round(2)
  end

  # Original method from Iteration 2
  def count_of_games_by_season
    @games[:season].tally
  end

  # Original method from Iteration 2
  def average_goals_per_game
    total_goals = @games[:away_goals].map(&:to_i).sum.to_f + @games[:home_goals].map(&:to_i).sum
    (total_goals / @games.size).round(2)
  end

  # Helper method used in average_goals_by_season
  def total_goals_per_season
    goals_per_season = Hash.new
    @games.each do |game|
      if goals_per_season.include?(game[:season])
        goals_per_season[game[:season]] += ([game[:away_goals].to_f]+[game[:home_goals].to_f]).sum
      elsif !goals_per_season.include?(game[:season])
        goals_per_season[game[:season]] = ([game[:away_goals].to_f]+[game[:home_goals].to_f]).sum
      end
    end
    goals_per_season
  end

  # Original method from Iteration 2
  def average_goals_by_season
    season_goal_averages = Hash.new
    total_goals_per_season.each do |season, goals|
      season_goal_averages[season] = (goals / count_of_games_by_season[season]).round(2) 
    end
    season_goal_averages
  end
#-----------------------------------League Statistics-----------------------------------
  # Original method from iteration 2
  def count_of_teams
    @teams.length
  end

  # Helper method used in best_offense, worst_offense - Added as part of I3 refactor
  def avg_goals_per_game
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
    # Create an array with each team and their avg goals per game in nested arrays
    # Refactor to return a hash?
    avg_goals_per_game = hash.map do |team_id, games_goals_hash|
      [team_id, (games_goals_hash[:goals].to_f/games_goals_hash[:games])]
    end
    avg_goals_per_game
  end

  # Original method from iteration 2
  def best_offense
    team_goals_per_game = avg_goals_per_game
    # Find the team_id and name of the team w/ highest avg goals
    best_offense_id = team_goals_per_game.max_by {|team_id, avg_goals| avg_goals}[0]
    @teams.find {|team| team[:team_id] == best_offense_id}[:teamname]
  end

  # Original method from iteration 2
  def worst_offense
    team_goals_per_game = avg_goals_per_game
    worst_offense_id = team_goals_per_game.min_by {|team_id, avg_goals| avg_goals}[0]
    @teams.find {|team| team[:team_id] == worst_offense_id}[:teamname]
  end

  # Helper method is used in average_scores_for_all_visitors & average_scores_for_all_home_teams
  # Recommend refactor by mixin 'calculator'
  def average_score_per_game(game_teams_selection)
    goals = game_teams_selection.sum {|game| game[:goals].to_f}
    # You need to / 2. The game_teams CSV has 2 lines to represent one game.
    games = (game_teams_selection.length.to_f/2.0)
    goals / games
  end

  # Helper method is used in average_scores_for_all_visitors
  # Recommend refactor as similar to method home_games_by_team_id & winning_as_coach
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

  # Original method from Iteration 2
  def highest_scoring_visitor
    average_scores_for_all_visitors
    highest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @visitor_hash.key(@visitor_hash.values.max)
    end
    highest_scoring_team[:teamname]
  end

  # Original method from Iteration 2
  def highest_scoring_home_team
    average_scores_for_all_home_teams
    highest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @home_hash.key(@home_hash.values.max)
    end
    highest_scoring_team[:teamname]
  end

  # Original method from Iteration 2
  def lowest_scoring_visitor
    average_scores_for_all_visitors
    lowest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @visitor_hash.key(@visitor_hash.values.min)
    end
    lowest_scoring_team[:teamname]
  end

  # Original method from Iteration 2
  def lowest_scoring_home_team
    average_scores_for_all_home_teams
    highest_scoring_team = @teams.find do |team|
      team[:team_id].to_i == @home_hash.key(@home_hash.values.min)
    end
    highest_scoring_team[:teamname]
  end
#-----------------------------------Season Statistics-----------------------------------
  # Helper method is used in most_accurate_team & least_accurate_team
  # Returns an array of all @game_teams rows from a given season
  # Commented out lines are unnecessary as the game_id's first 4 digits correspond to the first year of the season
  # First commented out line returns an array of all @games rows from a given season
  def season_game_teams(season)
    # season_games = @games.find_all{|row| row[:season] == season}
    # season_game_ids = season_games.map {|row| row[:game_id]}
    # season_game_teams = @game_teams.find_all {|row| season_game_ids.include?(row[:game_id])}
    season_game_teams = @game_teams.find_all {|row| row[:game_id].start_with?(season[0..3])}
  end

 # Helper method is used in winningest_coach
  def game_wins_by_season(season)
    games_by_season
    game_id_by_season = @games_by_season_hash[season]
    @wins_by_season = @game_teams.find_all {|game| game[:result] == "WIN" && game_id_by_season.include?(game[:game_id])}
  end

  # Helper method is used in winningest_coach
  def total_games_by_coaches_by_season(season)
    games_by_season
    game_id_by_season = @games_by_season_hash[season]
    @games_by_coaches_by_season = Hash.new([])
    @game_teams.each do |game|
      if game_id_by_season.include?(game[:game_id])
        @games_by_coaches_by_season[game[:head_coach]] += [game]
      end
    end
  end

 # Helper method is used in winningest_coach
  def coach_stats_by_season(season)
    game_wins_by_season(season)
    total_games_by_coaches_by_season(season)
    @coaches_wins_to_losses = Hash.new
    @games_by_coaches_by_season.each do |coach, game|
      @coaches_wins_to_losses[coach] = (@wins_by_season.count {|game| game[:head_coach] == coach }.to_f / @games_by_coaches_by_season[coach].length).round(2)
    end
  end

  # Original method from Iteration 2
  def winningest_coach(season)
    coach_stats_by_season(season)
    @coaches_wins_to_losses.key(@coaches_wins_to_losses.values.max)
  end

   # Original method from Iteration 2
   def worst_coach(season)
    coach_stats_by_season(season)
    @coaches_wins_to_losses.key(@coaches_wins_to_losses.values.min)
  end

  # Helper method used in most_accurate_team and least_accurate_team
  def season_shots_to_goals(season)
    season_game_teams = season_game_teams(season)
    shots_to_goals = Hash.new(0)
    season_shots = Hash.new(0)
    season_goals = Hash.new(0)
    season_game_teams.each { |row| season_goals[row[:team_id]] += row[:goals].to_f }
    season_game_teams.each { |row| season_shots[row[:team_id]] += row[:shots].to_f }
    season_shots.keys.each {|team_id| shots_to_goals[team_id] = season_shots[team_id]/season_goals[team_id]}
    shots_to_goals
  end

  # Original method from Iteration 2
  def most_accurate_team(season)
    shots_to_goals = season_shots_to_goals(season)
    most_accurate_team_id = (shots_to_goals.min_by {|team_id, ratio| ratio})[0]
    most_accurate_team = @teams.find do |team|
      team[:team_id] == most_accurate_team_id
    end
    most_accurate_team[:teamname]
  end

  # Original method from Iteration 2
  def least_accurate_team(season)
    shots_to_goals = season_shots_to_goals(season)
    least_accurate_team_id = (shots_to_goals.max_by {|team_id, ratio| ratio})[0]
    least_accurate_team = @teams.find do |team|
      team[:team_id] == least_accurate_team_id
    end
    least_accurate_team[:teamname]
  end

  # Helper method is used in tackles_by_team
  def games_by_season
    @games_by_season_hash = Hash.new([])
    @games.each do |game|
      @games_by_season_hash[game[:season]] += [game[:game_id]]
    end
    @games_by_season_hash
  end

  # Helper method is used in most_tackles & fewest_tackles
  # Recommend refactor into 2 methods. 1. Selects games in a given season. 2. Finds tackles in that set of games.
  def tackles_by_team(season)
    games_by_season
    games_in_select_season = @games_by_season_hash[season]
    @tackles_counter = Hash.new(0)
    @game_teams.each do |game|
      if games_in_select_season.include?(game[:game_id])
        @tackles_counter[game[:team_id]] += game[:tackles].to_i
      end
    end
    @tackles_counter
  end


  # Original method from Iteration 2
  def most_tackles(season)
    tackles_by_team(season)
    team_with_most_tackles = @teams.find do |team|
      team[:team_id] == @tackles_counter.key(@tackles_counter.values.max)
    end
    team_with_most_tackles[:teamname]
  end

  # Original method from Iteration 2
  def fewest_tackles(season)
    tackles_by_team(season)
    team_with_least_tackles = @teams.find do |team|
      team[:team_id] == @tackles_counter.key(@tackles_counter.values.min)
    end
    team_with_least_tackles[:teamname]
  end
#------------------------------------Team Statistics------------------------------------
  # Original method from Iteration 2
  def team_info(team_id)
    team_info_hash = Hash.new
    @teams.each do |team|
      if team[:team_id] == team_id
        team_info_hash['team_id'] = team[:team_id]
        team_info_hash['franchise_id'] = team[:franchiseid]
        team_info_hash['team_name'] = team[:teamname]
        team_info_hash['abbreviation'] = team[:abbreviation]
        team_info_hash['link'] = team[:link]
      end
    end
    team_info_hash
  end

  # Helper method is used in best_season & worst_season
  def games_by_team_by_season(team_id)
    games_by_season
    @games_by_team_by_season_hash = Hash.new([])
    @games_by_season_hash.each do |season, games_array|
      @games_by_team_by_season_hash[season] += @game_teams.find_all {|game| team_id == game[:team_id] && games_array.include?(game[:game_id])}
    end
    @games_by_team_by_season_hash
  end

  # Original method from Iteration 2
  def best_season(team_id)
    games_by_team_by_season(team_id)
    game_wins_by_team_by_season = Hash.new
    @games_by_team_by_season_hash.each do |season, games_by_team|
      game_wins_by_team_by_season[season] = ((games_by_team.count {|game| game[:result] == "WIN"}.to_f/games_by_team.length.to_f) * 100).round(2)
    end
    game_wins_by_team_by_season.key(game_wins_by_team_by_season.values.max)
  end

  # Original method from Iteration 2
  def worst_season(team_id)
    games_by_team_by_season(team_id)
    game_wins_by_team_by_season = Hash.new
    @games_by_team_by_season_hash.each do |season, games_by_team|
      game_wins_by_team_by_season[season] = ((games_by_team.count {|game| game[:result] == "WIN"}.to_f/games_by_team.length.to_f) * 100).round(2)
    end
    game_wins_by_team_by_season.key(game_wins_by_team_by_season.values.min)
  end


  # Helper method is used in average_win_percentage & most_goals_scored & fewest_goals_scored
  def games_by_team
    @games_by_team_hash = Hash.new([])
    @game_teams.each do |game|
      @games_by_team_hash[game[:team_id]] += [game]
    end
    @games_by_team_hash
  end

  # Original method from Iteration 2
  def average_win_percentage(team_id)
    games_by_team
    games_to_check = @games_by_team_hash[team_id]
    (games_to_check.count {|game| game[:result] == 'WIN'}.to_f / games_to_check.length.to_f).round(2)
  end

  # Original method from Iteration 2
  def most_goals_scored(team_id)
    games_by_team
    games_to_check = @games_by_team_hash[team_id]
    game_most_goals = games_to_check.max_by {|game| game[:goals].to_i}
    game_most_goals[:goals].to_i
  end

  # Original method from Iteration 2
  def fewest_goals_scored(team_id)
    games_by_team
    games_to_check = @games_by_team_hash[team_id]
    game_least_goals = games_to_check.min_by {|game| game[:goals].to_i}
    game_least_goals[:goals].to_i
  end


  # Helper method is used in opponent_win_loss
  def team_games_opponents(team_id)
    team_games_opponents = {}
    # Keys of team_games_opponents should be game_ids of games team is involved in
    # Values of team_games_opponents should be the team_id of their opponent in that game
    @games.each do |game|
      if game[:away_team_id] == team_id
        team_games_opponents[game[:game_id]] = game[:home_team_id]
      elsif game[:home_team_id] == team_id
        team_games_opponents[game[:game_id]] = game[:away_team_id]
      end
    end
    team_games_opponents
  end

  # Helper method is used in favorite_opponent & rival
  def opponent_win_loss(team_id)
    team_games_opponents = team_games_opponents(team_id)
    # Keys of opponent_win_loss should be the team_id of their opponents
    # Values of opponent_win_loss should be an array with 1st element being wins, 2nd element being losses
    opponent_win_loss = {}
    # Instantiating each key-value pair
    team_games_opponents.values.uniq.each do |opponent_id|
      opponent_win_loss[opponent_id] = [0,0]
    end

    @game_teams.each do |game|
      if team_games_opponents.keys.include?(game[:game_id]) && team_games_opponents.values.include?(game[:team_id])
        if game[:result] == "WIN"
          opponent_win_loss[game[:team_id]][0] += 1
        elsif game[:result] =="LOSS"
          opponent_win_loss[game[:team_id]][1] += 1
        end
      end
    end
    opponent_win_loss
  end

  # Original method from Iteration 2
  def favorite_opponent(team_id)
    opponent_win_loss = opponent_win_loss(team_id)

    favorite_opponent_id = opponent_win_loss.min_by{|opponent, win_loss| win_loss[0].to_f/win_loss[1]}[0]
    favorite_opponent = @teams.find do |team|
      team[:team_id] == favorite_opponent_id
    end
    favorite_opponent[:teamname]
  end

  # Original method from Iteration 2
  def rival(team_id)
    opponent_win_loss = opponent_win_loss(team_id)

    rival_id = opponent_win_loss.max_by{|opponent, win_loss| win_loss[0].to_f/win_loss[1]}[0]
    rival = @teams.find do |team|
      team[:team_id] == rival_id
    end
    rival[:teamname]
  end
end