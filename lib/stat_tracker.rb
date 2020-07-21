require 'CSV'

class StatTracker

  attr_reader :games_data,
              :teams_data,
              :game_teams_data,
              :games,
              :teams,
              :game_stats
  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @games_data = data[:games]
    @teams_data = data[:teams]
    @game_teams_data = data[:game_teams]
    @games = {}
    @teams = {}
    @game_stats = Hash.new{|hash, key| hash[key] = {} }
  end

  def generate_games
    CSV.foreach(@games_data, headers: true, header_converters: :symbol) do |row|
      @games[row[:game_id]] = Game.new(row)
    end
  end

end
