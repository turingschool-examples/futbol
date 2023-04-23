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

    # def self.from_csv(database_hash)
    #   # first iterate through database and access whichever one you want
    #   data_hash = {}
    #   database_hash.map do |key, value|
    #     if key == :games
    #       game_data_method(value)
    #     end
    #     # elsif key == :teams
    #     #   teams = CSV.read(database_hash[:teams], headers: true, header_converters: :symbol).map do |row|
    #     #   require 'pry'; binding.pry
    #     #   end
    #   end
    # end

    # def game_data_method(value)
    #   @game_data = CSV.open(value[:games], headers: true, header_converters: :symbol)
    #   @games = game_data.map do |game|
    #     Game.new = (
    #       row[:id],
    #       row[:season],
    #       row[:type],
    #       row[:away_team_id],
    #       row[:home_team_id],
    #       row[:away_goals],
    #       row[:home_goals],
    #       row[:venue]
    #     )
    #   end
    #   new(@games)
    # end




    # game_array = []
    # games = CSV.read(database_hash[:games], headers: true, header_converters: :symbol).map do |row|
    #   one_game = Game.new(
    #         row[:game_id],
    #         row[:season],
    #         row[:type],
    #         row[:away_team_id],
    #         row[:home_team_id],
    #         row[:away_goals,],
    #         row[:home_goals],
    #         row[:venue]
    #   )
    # end
    # game_array << games
    # data_hash[:games] = game_array.flatten
    # require 'pry'; binding.pry
    # new(games)
  # end




  #       if key == :games
  #         games =
  #           one_game = Game.new(
  #                 row[:game_id],
  #                 row[:season],CSV.read(database_hash[:games], headers: true, header_converters: :symbol).map do |row|
  #                 row[:type],
  #                 row[:away_team_id],
  #                 row[:home_team_id],
  #                 row[:away_goals,],
  #                 row[:home_goals],
  #                 row[:venue]
  #           )
  #         # data_hash[:teams] = team_array
  #       else
  #         teams = CSV.read(database_hash[:teams], headers: true, header_converters: :symbol).map do |row|
  #           one_team = Team.new(
  #             row[:team_id],
  #             row[:franchiseid],
  #             row[:teamname],
  #             row[:stadium]
  #           )
  #         end
  #       end
  #     end
  #   end
  # end

  #   # first iterate through database and access whichever one you want
  #   data_hash = {}
  #   game_array = []
  #   team_array = []

  #   games = CSV.read(database_hash[:games], headers: true, header_converters: :symbol).map do |row|
  #     one_game = Game.new(
  #           row[:game_id],
  #           row[:season],
  #           row[:type],
  #           row[:away_team_id],
  #           row[:home_team_id],
  #           row[:away_goals,],
  #           row[:home_goals],
  #           row[:venue]
  #     )
  #   end
  #   teams = CSV.read(database_hash[:teams], headers: true, header_converters: :symbol).map do |row|
  #     one_team = Team.new(
  #       row[:team_id],
  #       row[:franchiseid],
  #       row[:teamname],
  #       row[:stadium]
  #     )
  #   end
  #   team_array << teams
  #   data_hash[:teams] = team_array.flatten
  #   # game_teams = CSV.read(database_hash[:game_teams], headers: true, header_converters: :symbol).map do |row|
  #   # end
  #   game_array << games
  #   data_hash[:games] = game_array.flatten

  #   new(data_hash)
  # end

      # def self.from_csv(database_hash)
    #   data_hash = {}
    #   game_array = []
    #   team_array = []
    #   database_hash.map do |key, value|
    #     data_hash[key] = CSV.read(value, headers: true, header_converters: :symbol)
    #     data_hash.each do |key, data|
    #       if key == :games
    #         data.each do |row|
    #          require 'pry'; binding.pry
    #         end
    #       end
    #     end


    #     # if key == :games
    #     #   game_data_method(value)
    #   end
    # end
  # def self.from_csv(database_hash)
  #   # first iterate through database and access whichever one you want
  #   data_hash = {}
  #   database_hash.map do |key, value|
  #   require 'pry'; binding.pry
  #   end
  #   game_array = []
  #   games = CSV.read(database_hash[:games], headers: true, header_converters: :symbol).map do |row|
  #     one_game = Game.new(
  #           row[:game_id],
  #           row[:season],
  #           row[:type],
  #           row[:away_team_id],
  #           row[:home_team_id],
  #           row[:away_goals,],
  #           row[:home_goals],
  #           row[:venue]
  #     )
  #   end
  #   game_array << games
  #   data_hash[:games] = game_array.flatten
  #   require 'pry'; binding.pry
  #   new(games)
  # end

  # def lowest_scoring_home_team
  #     # home_team_goals = Hash.new(0)
  #   # @games.each do |game|
  #   #   home_team_goals[game.home_team_id] = home_team_goals[game.home_team_id] + game.home_goals
  #   # end
  #   # avg_goals = Hash.new(0)
  #   # home_games = @games.group_by { |game| game.home_team_id }.transform_values {|games| games.count {|game| game } }
  #   # lowest_percentage = home_team_goals.map { |key, value| avg_goals[key] = value.to_f / home_games[key] }
  #   # team_id_min_value = avg_goals.min_by {|id , low_value| low_value }.first
  # end