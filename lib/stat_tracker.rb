require 'CSV'

class StatTracker
    @@all_teams = []

  def self.all
    @all_teams
  end

  def self.from_csv(locations)
    teams_csv = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams_csv = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    @@all_games = games_csv.map do |row|
      Game.new(row)
    end

    StatTracker.new(@@all_games)
  end

  def initialize(games_csv)
    @games_csv = games_csv
    @teams_csv = 0
    @game_teams_csv = 0
  end



end
