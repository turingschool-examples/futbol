require_relative "game_teams"
require "csv"
require "pry"

class SeasonStats
  def initialize(locations)
    require "pry"
    binding.pry

    @game_teams = CSV.open(locations[:game_teams], headers: true, header_converters: :symbol).map { |game_team| GameTeams.new(game_team) }
  end

  def winningest_coach
    # Name of the Coach with the best win percentage for the season
  end

  def worst_coach
    # Name of the Coach with the worst win percentage for the season
  end

  def most_accurate_team
    # Name of the Team with the best ratio of shots to goals for the season
  end

  def least_accurate_team
    # Name of the Team with the worst ratio of shots to goals for the season
  end

  def most_tackles
    # Name of the Team with the most tackles in the season
    @game_teams.each do |data|
    end
  end

  def fewest_tackles
    # Name of the Team with the fewest tackles in the season
  end
end
