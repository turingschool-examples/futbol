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

  # League Statistics
  def count_of_teams
    number_of_teams = team_data.map do |team|
      team
    end
    number_of_teams.count
  end

  # Season Statistics
  def most_tackles(season_id)
    find_season = games_data.find_all do |game|
      game[:season] == season_id
    end

    test_game_id = game_teams_data.find_all do |team|
      find_season.each do |season_asdf|
        team[:game_id] == season_asdf[:game_id]
      end
    end

    result = test_game_id.max_by do |game_team|
      game_team[:tackles]
    end

    name_result = team_data.find do |team|
      team[:team_id] == result[:team_id]
    end
    name_result[:teamname]
  end
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
end
