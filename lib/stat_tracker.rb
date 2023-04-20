require 'csv'
require_relative 'game' #does this need a longer filepath?

class StatTracker

  def initialize(database_hash)
    @games = CSV.open(database_hash[:games], headers: true, header_converters: :symbol)
    # @games = self.from_csv(database_hash)
    @game_data = game_data_method
    @team_data = team_data_method
  end

  def self.from_csv(database_hash)
    games = CSV.readlines(database_hash[:games], headers: true, header_converters: :symbol).map do |row|
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
    require 'pry'; binding.pry
    end
    # games = CSV.foreach
    # new_array = games.readlines
    # new_array.each do |row|
    # end
  end

  def game_data_method(location)
    from_csv(location[:game])
    # require 'pry'; binding.pry
    locations == locations[:game]
    @game_data = CSV.open(locations, headers)
    @games = game_data.map do |game|
      Game.new = (

      )
    end
  end

  def team_data_method(location)
    Team.new
  end


  def some_game_method
    @game_data.from_csv #first the method will instantiate whatever data set it needs
    #second the method will run the actual method on that instantiated array list
  end

  def next_methoed
    # first call from_csv method to instantiate array of data
    # do the cool things
  end
end