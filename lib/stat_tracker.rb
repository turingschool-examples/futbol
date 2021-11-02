require './lib/game_team'
require './lib/team'
require './lib/game'

class StatTracker
  attr_accessor :location
  def initialize(location)
    @location = location
  end

  def self.from_csv(locations)
    locations.map do |location|
      # require 'pry'; binding.pry
      StatTracker.new(location)
    end
  end

  def read_game_stats(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      game = Game.new(row)
    end
  end

  def read_team_stats(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      team = Team.new(row)
    end
  end

  def read_game_teams_stats(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      game_team = GameTeam.new(row)
      require 'pry'; binding.pry
    end
  end


end
