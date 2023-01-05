require 'csv'

class StatTracker
  attr_reader :data_array,
              :games,
              :teams,
              :game_teams


  def self.from_csv(locations)
    @data_array = locations.values.map {|location| location }
    @stat_tracker = StatTracker.new(@data_array)
  end

  def initialize(data_array)
    @data_array = data_array
    @games = CSV.read @data_array[0], headers: true, header_converters: :symbol
    @teams = CSV.read @data_array[1], headers: true, header_converters: :symbol
    @game_teams = CSV.read @data_array[2], headers: true, header_converters: :symbol
  end

  def highest_total_score
    @games.map {|row| row[:home_goals].to_i + row[:away_goals].to_i}.max
  end

  def average_goals_per_game
    total_games = @games.map { |row| row[:game_id]}.count
    total_goals = @games.map { |row| row[:home_goals].to_i + row[:away_goals].to_i}.sum
    (total_goals.to_f / total_games).round(2)
  end


  def average_goals_by_season
    # average_goals_by_season = {}
    # goal_amounts = []
    # all_seasons = @games.map { |row| row[:season]}
    #   all_seasons.uniq.each do |season|
    #     @games.each do |row| 
    #       if row[:season] == season 
    #         goals = row[:home_goals].to_i + row[:away_goals].to_i
    #         goal_amounts << goals
    #         # require 'pry'; binding.pry
    #   end
    # end 
    # all_seasons.uniq.each do |season|
    #   average_goals_by_season[season] = goal_amounts.sum
    # # require 'pry'; binding.pry
    #  average_goals_by_season 
    #   end
    # end
  end 

   def count_of_games_by_season
    count_of_games_by_season = Hash.new(0)
         seasons = @games.map { |row| row[:season]}.tally
   end

  def percentage_home_wins
    tally = 0
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "home" && row[:result] == "WIN") || (row[:hoa] == "away" && row[:result] == "LOSS")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_visitor_wins
    tally = 0
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "away" && row[:result] == "WIN") || (row[:hoa] == "home" && row[:result] == "LOSS")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_ties
    tally = 0 
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "away" && row[:result] == "TIE") || (row[:hoa] == "home" && row[:result] == "TIE")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end
  
  def winningest_coach(season_id)
    wins_hash = Hash.new(0)
    games_list = list_games_by_season(season_id)

    @game_teams.each do |row|
      if games_list.include?(row[:game_id])
        wins_hash[row[:head_coach]] += 1 if row[:result] == "WIN"
      end
    end
    require 'pry'; binding.pry
    winningest_coach_id = wins_hash.max_by{|k,v| v}[0]
  end
  
  def list_games_by_season(season_id)
    games_list = []
    @games.each do |row|
      games_list << row[:game_id] if row[:season] == season_id
    end
    games_list
  end
  
end






# #I need total games per team in a season.
# total_games(season_id) == @games.map { |row| row[:game_id]}.count
# #I need total wins per team in that season.
# team_id = @teams.map { |row| row[:team_id]}
# total_wins(team_id) == @game_teams.map do |row|
#   if ()
# end
# #Wins / total season games
# #return coaches name with highest winning percentage in season.

# #total_games_hash = {}
# games_list = []

# @games.each do |row|
#   if row[:season] == season_id 
#     games_list << row[:game_id]
#   end
# end

# total_games = []
# @game_teams.each do |row|
#   if games_list.include?(row[:game_id])
#     total_games << row[:head_coach] if (row[:result] == "WIN") || (row[:result] == "LOSS") || (row[:result] == "TIE")
#   end
# end

# wins_list =[]
# @game_teams.each do |row|
#   if games_list.include?(row[:game_id])
#     wins_list << row[:head_coach] if (row[:result] == "WIN")
#   end
# end
# coach_percentages = {}
# total_games.tally.each do |coach, total|
#   wins_list.tally.each do |name, win|
#     #require 'pry'; binding.pry
#     if coach == name 
#       final_percent = win.to_f / total.to_f
#       coach_percentages[name] == final_percent
#     end
#   end
# end

# # wins_list.tally.values / total_games.tally.values
# #return head_coach with highest win percentage
# # total_games.tally























