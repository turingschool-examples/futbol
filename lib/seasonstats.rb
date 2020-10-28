require 'csv'

class SeasonStats
  def self.from_csv(locations)
    SeasonStats.new(locations)
  end

  def initialize(locations)
    @locations = locations
    @games_teams_table = CSV.parse(File.read(@locations[:game_teams]), headers: true)
    @games_table = CSV.parse(File.read(@locations[:games]), headers: true)
  end

  def games_in_season(season)
    @games_table.find_all do |game|
      game["season"] == season
    end
  end


  def winningest_coach(season)
    require "pry"; binding.pry
    games_in_season(season)
  end

end
