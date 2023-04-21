class Test

  attr_reader :test
  def initialize
    @test = "test"
  end

#helper method?
#   def game_method(data)
#     games = CSV.readlines(database_hash[:games], headers: true, header_converters: :symbol).map do |row|
#       one_game = Game.new(
#             row[:game_id],
#             row[:season],
#             row[:type],
#             row[:away_team_id],
#             row[:home_team_id],
#             row[:away_goals,],
#             row[:home_goals],
#             row[:venue]
#       )
#       require 'pry'; binding.pry
#     end
#   end

# end