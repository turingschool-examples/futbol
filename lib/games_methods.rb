require_relative 'game'
require 'csv'
class Games
  attr_reader :games

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def create_games(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    csv.map do |row|
       Game.new(row)
    end
  end
end
# Method	Description	Return Value
### highest_total_score	###Highest sum of the winning and losing teams’ scores	Integer
### lowest_total_score ###	Lowest sum of the winning and losing teams’ scores	Integer
### percentage_home_wins ###	Percentage of games that a home team has won
# (rounded to the nearest 100th)	Float
### percentage_visitor_wins ### Percentage of games that a visitor has won
# (rounded to the nearest 100th)	Float
### percentage_ties	### Percentage of games that has resulted in a tie
# (rounded to the nearest 100th)	Float
### count_of_games_by_season ###	A hash with season names (e.g. 20122013)
# as keys and counts of games as values	Hash
### average_goals_per_game ###	Average number of goals scored in a game across all
# seasons including both home and away goals (rounded to the nearest 100th)	Float
### average_goals_by_season	### Average number of goals scored in a game organized
# in a hash with season names (e.g. 20122013) as keys and a float representing
#the average number of goals in a game for that season as a key (rounded to the nearest 100th)
