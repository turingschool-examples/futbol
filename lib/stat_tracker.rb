require 'csv'
require_relative 'game' #does this need a longer filepath?

class StatTracker
  # attr_reader :highest_total_scored
  def initialize(data)
    @games = data
  end


  def self.from_csv(database_hash)
    # first iterate through database and access whichever one you want
    games = CSV.read(database_hash[:games], headers: true, header_converters: :symbol).map do |row|
      one_game = Game.new(
            row[:game_id],
            row[:season],
            row[:type],
            row[:away_team_id],
            row[:home_team_id],
            row[:away_goals,],
            row[:home_goals],
            row[:venue]
      )
    end
    new(games)
  end



  def highest_total_score

    require 'pry'; binding.pry
  end



end