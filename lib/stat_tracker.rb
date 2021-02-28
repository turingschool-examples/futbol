require 'CSV'

class StatTracker
  attr_reader :games_data,
              :team_data,
              :game_teams_data

  def initialize(locations)
    # @locations = locations
    @games_data = CSV.parse(File.read('./data/games.csv'), headers: true, header_converters: :symbol)
    @team_data = CSV.parse(File.read('./data/teams.csv'), headers: true, header_converters: :symbol)
    @game_teams_data = CSV.parse(File.read('./data/game_teams.csv'), headers: true, header_converters: :symbol)
    # @team_manager = TeamsManager.new(CSV.parse(File.read(locations[:teams]), headers: true, header_converters: :symbol), self)
    # @games_manager = GamesManager.new(CSV.parse(File.read(locations[:games]), headers: true, header_converters: :symbol), self)
    # @game_team_manager = GameTeamsManager.new(CSV.parse(File.read(locations[:game_teams]), headers: true, header_converters: :symbol), self)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

# Game Statistics
  def highest_total_score
    # games_data = CSV.parse(File.read('./dummy_data/games_dummy.csv'), headers: true, header_converters: :symbol)
    highest_score = 0
    games_data.each do |game|
      sum = game[:home_goals].to_i + game[:away_goals].to_i
      if sum > highest_score
        highest_score = sum
      end
    end
    highest_score
  end

  def lowest_total_score
    lowest_score = 100
    games_data.each do |game|
      sum = game[:home_goals].to_i + game[:away_goals].to_i
      if sum < lowest_score
        lowest_score = sum
      end
    end
    lowest_score
  end

  def percentage_home_wins
    number_home_wins = game_teams_data.find_all do |game|
      (game[:hoa] == "home") && (game[:result] == "WIN")
    end.size.to_f

    all_games = games_data.find_all do |game|
      game
    end.size

    (number_home_wins / all_games).round(2)
  end

  def percentage_visitor_wins
    number_visitor_wins = game_teams_data.find_all do |game|
      (game[:hoa] == "away") && (game[:result] == "WIN")
    end.size.to_f

    all_games = games_data.find_all do |game|
      game
    end.size

    (number_visitor_wins / all_games).round(2)
  end

  def percentage_ties
    (1 - (percentage_home_wins + percentage_visitor_wins)).round(2)
  end

  # League Statistics
  def count_of_teams
    number_of_teams = team_data.map do |team|
      team
    end
    number_of_teams.count
  end

  def average_goals_per_game
    sum = 0
    games_data.each do |game|
      sum += game[:away_goals].to_i
      sum += game[:home_goals].to_i
    end
    (sum.to_f / games_data.count).round(2)
  end

  def average_goals_by_season
    result = {}
    games_data.each do |game|
      goals = (game[:away_goals].to_f + game[:home_goals].to_f)
      result[game[:season]] = [] if result[game[:season]].nil?
      result[game[:season]].push(goals)
    end
    bucket = result.transform_values {|value| (value.sum / value.length).round(2)}
  end

  # Season Statistics

  # def most_tackles(season_id)
  #   find_season = games_data.find_all do |game|
  #     game[:season] == season_id
  #   end
  #
  #   games_array = []
  #   find_season.each do |season|
  #     games_array << season[:game_id]
  #   end
  #
  #   nuther_array = []
  #   game_teams_data.each do |rows|
  #     games_array.each do |id|
  #       nuther_array << rows if rows[:game_id] == id
  #     end
  #   end
  #   most_tackles = nuther_array.max_by {|rows| rows[:tackles]}
  # end

  # Team Statistics
  # A hash with key/value pairs for the following attributes: team_id,
  # franchise_id, team_name, abbreviation, and link
  def team_info(team_id)
    team_data_string_headers = CSV.parse(File.read('./data/teams.csv'), headers: true)
    team_info = team_data_string_headers.find do |team|
      # require "pry"; binding.pry
      team["team_id"] == team_id
    end
    team_deets = team_info.to_h
    team_deets.delete("Stadium")
    team_deets["team_name"] = team_deets["teamName"]
    team_deets.delete("teamName")
    team_deets["franchise_id"] = team_deets["franchiseId"]
    team_deets.delete("franchiseId")
    team_deets
  end

  def fewest_goals_scored(team_id)
    team_result = []
    game_teams_data.each do |games|
      team_result << games if games[:team_id] == team_id
    end
    goals = team_result.min_by do |result|
      result[:goals]
    end[:goals].to_i
  end

  def most_goals_scored(team_id)
    team_result = []
    game_teams_data.each do |games|
      team_result << games if games[:team_id] == team_id
    end
    goals = team_result.max_by do |result|
      result[:goals]
    end[:goals].to_i
  end

  def highest_scoring_home_team
    grouped = {}
    games_data.each do |game|
      grouped[game[:home_team_id]] = [] if grouped[game[:home_team_id]].nil?
      grouped[game[:home_team_id]] << game[:home_goals].to_f
    end
    averaged = grouped.transform_values do |values|
      (values.sum / values.length).round(2)
    end
    result = averaged.max_by {|key, value| value}
    find_team = team_data.find {|team| team[:team_id] == result[0]}
    find_team[:teamname]
  end

  def lowest_scoring_home_team
    grouped = {}
    games_data.each do |game|
      grouped[game[:home_team_id]] = [] if grouped[game[:home_team_id]].nil?
      grouped[game[:home_team_id]] << game[:home_goals].to_f
    end
    averaged = grouped.transform_values do |values|
      (values.sum / values.length).round(2)
    end
    result = averaged.min_by {|key, value| value}
    find_team = team_data.find {|team| team[:team_id] == result[0]}
    find_team[:teamname]
  end

  def highest_scoring_visitor
    grouped = {}
    games_data.each do |game|
      grouped[game[:away_team_id]] = [] if grouped[game[:away_team_id]].nil?
      grouped[game[:away_team_id]] << game[:away_goals].to_f
    end
    averaged = grouped.transform_values do |values|
      (values.sum / values.length).round(2)
    end
    result = averaged.max_by {|key, value| value}
    find_team = team_data.find {|team| team[:team_id] == result[0]}
    find_team[:teamname]
  end

  def lowest_scoring_visitor
    grouped = {}
    games_data.each do |game|
      grouped[game[:away_team_id]] = [] if grouped[game[:away_team_id]].nil?
      grouped[game[:away_team_id]] << game[:away_goals].to_f
    end
    averaged = grouped.transform_values do |values|
      (values.sum / values.length).round(2)
    end
    result = averaged.min_by {|key, value| value}
    find_team = team_data.find {|team| team[:team_id] == result[0]}
    find_team[:teamname]
  end

  def winningest_coach(season_id)
    season = []
    games_data.each do |game|
      season << game[:game_id] if game[:season] == season_id
    end
    result = {}
    game_teams_data.each do |game_team|
      season.each do |game_id|
        if game_id == game_team[:game_id]
          result[game_team[:head_coach]] = [] if result[game_team[:head_coach]].nil?
          result[game_team[:head_coach]] << game_team[:result]
        end
      end
    end
    average = result.transform_values do |value|
      (value.count("WIN") / value.length.to_f)
    end
    winning_coach = average.max_by {|key, value| value}
    winning_coach[0]
  end

  def worst_coach(season_id)
    season = []
    games_data.each do |game|
      season << game[:game_id] if game[:season] == season_id
    end
    result = {}
    game_teams_data.each do |game_team|
      season.each do |game_id|
        if game_id == game_team[:game_id]
          result[game_team[:head_coach]] = [] if result[game_team[:head_coach]].nil?
          result[game_team[:head_coach]] << game_team[:result]
        end
      end
    end
    average = result.transform_values do |value|
      (value.count("WIN") / value.length.to_f)
    end
    worst_coach = average.min_by {|key, value| value}
    worst_coach[0]
  end
  # def best_season(team_id)
  #   number_wins = 0
  #   result = []
  #   games_data.each do |game|
  #     if game[:away_team_id] == team_id || game[:home_team_id] == team_id
  #       result << game
  #     end
  #   end
  #   require "pry"; binding.pry
  # end

end
