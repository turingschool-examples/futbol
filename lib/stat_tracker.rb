require 'CSV'

class StatTracker
  attr_reader :games_manager

  def initialize(locations)
    # @locations = locations
    # @team_manager = TeamsManager.new(CSV.parse(File.read(locations[:teams]), headers: true, header_converters: :symbol), self)
    # @games_manager = GamesManager.new(CSV.parse(File.read(locations[:games]), headers: true, header_converters: :symbol), self)
    # @game_team_manager = GameTeamsManager.new(CSV.parse(File.read(locations[:game_teams]), headers: true, header_converters: :symbol), self)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

# Game Statistics
  def highest_total_score
    games_data = CSV.parse(File.read('./dummy_data/games_dummy.csv'), headers: true, header_converters: :symbol)
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
    team_data = CSV.parse(File.read('./dummy_data/teams_dummy.csv'), headers: true, header_converters: :symbol)
    number_of_teams = team_data.map do |team|
      team
    end
    number_of_teams.count
  end

  # Season Statistics
  def most_tackles
    game_teams_data = CSV.parse(File.read('./dummy_data/game_teams_dummy.csv'), headers: true, header_converters: :symbol)
    team_data = CSV.parse(File.read('./dummy_data/teams_dummy.csv'), headers: true, header_converters: :symbol)

    result = game_teams_data.max_by do |game_team|
      game_team[:tackles]
    end

    name_result = team_data.find do |team|
      team[:team_id] == result[:team_id]
    end
    name_result[:teamname]
  end
end


# Team Statistics
