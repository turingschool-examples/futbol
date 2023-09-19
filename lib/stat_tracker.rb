require "csv"

class StatTracker
  def self.from_csv(locations)
    games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    new(games_data, teams_data, game_teams_data)
  end
  attr_accessor :games_data, :teams_data, :game_teams_data
  def initialize(games_data, teams_data, game_teams_data)
    @games_data = games_data
    @teams_data = teams_data
    @game_teams_data = game_teams_data
  end

  def highest_total_score
    highest_score = 0

    @games_data.each do |game|
      total_score = (game[:home_goals].to_i + game[:away_goals].to_i)

      highest_score = total_score if total_score > highest_score
      highest_score.round(1)
    end

    highest_score
  end

  def lowest_total_score
    lowest_score = 100

    @games_data.each do |game|
      total_score = (game[:home_goals].to_i + game[:away_goals].to_i)

      lowest_score = total_score if total_score < lowest_score
      lowest_score.round(1)
    end

    lowest_score
  end


end
