require 'CSV'

game_path = './dummy_data/games_dummy.csv'

# x = CSV.read(game_path, headers: true, header_converters: :symbol)
# x.each do |row|
#     require 'pry'; binding.pry
#     Game.new
# end

# game_scores = x.map do |game|
#     x.home_goals + x.away_goals
# end    
# game_scores.max






# require 'pry'; binding.pry
# game_scores = []

# CSV.foreach(game_path, headers: true, header_converters: :symbol) do |row|
#     game_scores << row[:home_goals].to_i + row[:away_goals].to_i
# end

# p game_scores.max

# p " NEW IDEA"

