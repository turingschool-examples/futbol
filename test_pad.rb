  #   def game_data_method(location)
  #     from_csv(location[:game])
  #     # require 'pry'; binding.pry
  #     locations == locations[:game]
  #     @game_data = CSV.open(locations, headers)
  #     @games = game_data.map do |game|
  #       Game.new = (

  #       )
  #     end
  #   end

  #   def team_data_method(location)
  #     Team.new
  #   end


  #   def some_game_method
  #     @game_data.from_csv #first the method will instantiate whatever data set it needs
  #     #second the method will run the actual method on that instantiated array list
  #   end

  #   def next_methoed
  #     # first call from_csv method to instantiate array of data
  #     # do the cool things
  #   end
  # end


  # def initialize(database_hash)
  #   @games = self.from_csv(database_hash[:games])
  #   require 'pry'; binding.pry
  # end

  # def initialize(database_hash)
    # @games = CSV.open(database_hash[:games], headers: true, header_converters: :symbol)
  #   # @games = self.from_csv(database_hash)
  #   # @game_data = game_data_method
  #   # @team_data = team_data_method
  # end

  