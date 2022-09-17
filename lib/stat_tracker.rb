require "csv"
require_relative './team'

class StatTracker
  attr_accessor :games_reader,
                :game_teams_reader,
                :teams_reader

  def initialize
    @teams_reader = nil
    @games_reader = nil
    @game_teams_reader = nil
  end

  def self.from_csv(locations)
    stat_tracker = new
    stat_tracker.teams_reader = CSV.read locations[:teams], headers: true, header_converters: :symbol
    stat_tracker.games_reader = CSV.read locations[:games], headers: true, header_converters: :symbol
    stat_tracker.game_teams_reader = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    stat_tracker
  end


  # Method to return the average number of goals scored in a game across all
  # seasons including both home and away goals (rounded to the nearest 100th)
  def average_goals_per_game
    total_goals = 0
    @games_reader.each do |game|
      total_goals += game[:away_goals].to_f
      total_goals += game[:home_goals].to_f
    end
    (total_goals / @games_reader.count).round(2)
  end

  # Method to return the average number of goals scored in a game organized in
  # a hash with season names as keys and a float representing the average number
  # of goals in a game for that season as values (rounded to the nearest 100th)
  def average_goals_by_season
    goals_per_season = Hash.new(0)
    @games_reader.each do |game|
      goals_per_season[game[:season]] += (game[:away_goals]).to_f
      goals_per_season[game[:season]] += (game[:home_goals]).to_f
    end
    goals_per_season.update(goals_per_season) do |season, total_goals|
      (total_goals / ((@games_reader[:season].find_all {|element| element == season}).count)).round(2)
    end
  end

  # Method to return name of the team with the highest average number of goals
  # scored per game across all seasons.
  def best_offense
    teams_hash = total_goals_by_team
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / ((@games_reader[:away_team_id].find_all {|element| element == team_id}).count +
      @games_reader[:home_team_id].find_all {|element| element == team_id}.count)
    end
    team_name_from_id(teams_hash.key(teams_hash.values.max))
  end

  # Helper method to return a hash with team ID keys and total goals by team
  # values
  def total_goals_by_team
    teams_hash = Hash.new(0)
    @teams_reader[:team_id].each do |team|
      @games_reader.each do |line|
        if line[:away_team_id] == team
          teams_hash[team] += line[:away_goals].to_f
        elsif line[:home_team_id] == team
          teams_hash[team] += line[:home_goals].to_f
        end
      end
    end
    teams_hash
  end

  # Helper method to return a team name from a team ID argument
  def team_name_from_id(team_id)
    @teams_reader[:teamname][@teams_reader[:team_id].index(team_id)]
  end

  # Method to return the name of the team with the lowest average number of
  # goals scored per game across all seasons.
  def worst_offense
    teams_hash = total_goals_by_team
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / ((@games_reader[:away_team_id].find_all {|element| element == team_id}).count +
      @games_reader[:home_team_id].find_all {|element| element == team_id}.count)
    end
    team_name_from_id(teams_hash.key(teams_hash.values.min))
  end

  # Method to return name of the team with the highest average score per game
  # across all seasons when they are home.
  def highest_scoring_home_team
    teams_hash = total_goals_by_team_by_at(:home_team_id)
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / @games_reader[:home_team_id].find_all {|element| element == team_id}.count
    end
    team_name_from_id(teams_hash.key(teams_hash.values.max))
  end

  # Method to return name of the team with the lowest average score per game
  # across all seasons when they are home.
  def lowest_scoring_home_team
    teams_hash = total_goals_by_team_by_at(:home_team_id)
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / @games_reader[:home_team_id].find_all {|element| element == team_id}.count
    end
    team_name_from_id(teams_hash.key(teams_hash.values.min))
  end

  # Helper method to retun hash with team_id as key and total goals at
  # home or away depending on the argument passed.
  def total_goals_by_team_by_at(at)
    teams_hash = Hash.new(0)
    @teams_reader[:team_id].each do |team|
      @games_reader.each do |line|
        teams_hash[team] += line[(at[0..4]).concat('goals').to_sym].to_f if line[at] == team
      end
    end
    teams_hash
  end

  # Method to return name of the team with the highest average score per game
  # across all seasons when they are away.
  def highest_scoring_visitor
    teams_hash = total_goals_by_team_by_at(:away_team_id)
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / @games_reader[:away_team_id].find_all {|element| element == team_id}.count
    end
    team_name_from_id(teams_hash.key(teams_hash.values.max))
  end

  # Method to return name of the team with the lowest average score per game
  # across all seasons when they are away.
  def lowest_scoring_visitor
    teams_hash = total_goals_by_team_by_at(:away_team_id)
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / @games_reader[:away_team_id].find_all {|element| element == team_id}.count
    end
    team_name_from_id(teams_hash.key(teams_hash.values.min))
  end

  def count_of_teams
   @teams_reader.length
  end

  def unique_total_goals
    goal_totals = []
      @games_reader.each do |row|
        if goal_totals.include?(row[:away_goals].to_i + row[:home_goals].to_i) == false
          goal_totals << row[:away_goals].to_i + row[:home_goals].to_i
        end
      end
    goal_totals
  end

  def highest_total_score
    unique_total_goals.max
  end

  def lowest_total_score
    unique_total_goals.min
  end

  def total_number_of_games
    @games_reader.length
  end

  def percentage_home_wins
   home_win_total = @game_teams_reader.count {|row| row[:result] == "WIN" && row[:hoa] == "home"}
   (home_win_total.to_f/total_number_of_games).round(2)
  end

  def percentage_visitor_wins
    home_visitor_total = @game_teams_reader.count {|row| row[:result] == "WIN" && row[:hoa] == "away"}
    (home_visitor_total.to_f/total_number_of_games).round(2)
  end

  def percentage_ties
    tie_total = @game_teams_reader.count {|row| row[:result] == "TIE" && row[:hoa] == "home"}
    (tie_total.to_f/total_number_of_games).round(2)
  end

  def team_finder(team_id)
    @teams_reader.find do |row|
      row[:team_id] == team_id
    end
  end

  def team_info(team_id)
    Team.new(team_finder(team_id)).team_labels
  end

  def average_win_percentage(team_id)
    team_win_total = @game_teams_reader.count {|row| row[:result] == "WIN" && row[:team_id] == team_id}
    total_team_games = @game_teams_reader.count {|row| row[:team_id] == team_id}
    (team_win_total.to_f/total_team_games).round(2)
  end

  def count_of_games_by_season
    seasons = Hash.new(0)
    @games_reader.each do |row|
      seasons[row[:season]] += 1
    end
    seasons
  end

  def most_goals_scored(team_id)
    unique_goal_totals = []
      @game_teams_reader.each do |row|
        if row[:team_id] == team_id && unique_goal_totals.include?(row[:goals].to_i) == false
          unique_goal_totals << row[:goals].to_i
        end
      end
    unique_goal_totals.max
  end

  def fewest_goals_scored(team_id)
    unique_goal_totals = []
      @game_teams_reader.each do |row|
        if row[:team_id] == team_id && unique_goal_totals.include?(row[:goals].to_i) == false
          unique_goal_totals << row[:goals].to_i
        end
      end
    unique_goal_totals.min
  end

  def most_tackles(season)
    team_tackles = Hash.new(0)
    @teams_reader[:team_id].each do |team|
      @game_teams_reader.each do |line|
        team_tackles[team] += line[:tackles].to_i if line[:game_id][0..3] == season[0..3] && line[:team_id] == team
      end
    end
    team_name_from_id(team_tackles.key(team_tackles.values.max))
  end

  def fewest_tackles(season)
    team_tackles = Hash.new(0)
    @teams_reader[:team_id].each do |team|
      @game_teams_reader.each do |line|
        team_tackles[team] += line[:tackles].to_i if line[:game_id][0..3] == season[0..3] && line[:team_id] == team
      end
    end
    team_name_from_id(team_tackles.key(team_tackles.values.min))
  end
  
  # Helper method to return hash of teams with team id keys and values of
  # total goals for the season
  def total_goals_by_team_season(season)
    team_scores = Hash.new(0)
    teams_array = @teams_reader[:team_id]
    teams_array.each do |team|
      @game_teams_reader.each do |line|
        team_scores[team] += (line[:goals]).to_i if line[:team_id] == team && line[:game_id][0..3] == season[0..3]
      end
    end
    team_scores
  end
  
  # Helper method to return hash of teams with team id keys and values of
  # total shots for the season
  def total_shots_by_team_season(season)
    teams_array = @teams_reader[:team_id]
    team_shots = Hash.new(0)
    teams_array.each do |team|
      @game_teams_reader.each do |line|
        team_shots[team] += line[:shots].to_f if line[:team_id] == team && line[:game_id][0..3] == season[0..3]
      end
    end
    team_shots
  end
  
  # Method to return the name of the Team with the best ratio of shots to goals 
  # for the season
  def most_accurate_team(season)
    team_scores = accuracy_by_team_season(season)
    team_name_from_id(team_scores.key(team_scores.values.max))
  end
  
  # Method to return the name of the Team with the worst ratio of shots to goals 
  # for the season
  def least_accurate_team(season)
    team_scores = accuracy_by_team_season(season)
    team_name_from_id(team_scores.key(team_scores.values.min))
  end
  
  # Helper method to return hash of teams with team id keys and values of
  # goals / shots for the season
  def accuracy_by_team_season(season)
    team_scores = total_goals_by_team_season(season)
    team_shots = total_shots_by_team_season(season)
    team_scores.update(team_scores) do |team, goals|
      goals / team_shots[team]
    end
    team_scores
  end
  
end