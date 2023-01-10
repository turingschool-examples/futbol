require 'csv'

class StatTracker 

  def initialize(locations)
    stats = Stats.new(locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

   ################## Game Statisics ##################

  def highest_total_score
  end

  def lowest_total_score
  end

  def total_scores
  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end
 
  def percentage_ties
  end

  def count_of_games_by_season
  end

  def average_goals_per_game 
  end
 
  def average_goals_by_season
  end

  def season_goals(season)
  end

   ################## League Statisics ##################

  def count_of_teams
  end

  def team_id_all_goals
  end

  def team_goal_avg(team_all_goals_hash)
  end

  def best_team_avg(id)
  end

  def best_offense
  end

  def worst_offense
  end

  def away_team_goals
  end

  def home_team_goals
  end

  def avg_team_goals(team_goals_hash)
  end

  def team_name(id)
  end

  def highest_scoring_visitor
  end
 
  def highest_scoring_home_team
  end

  def lowest_scoring_visitor
  end

  def lowest_scoring_home_team
  end

   ################## Season Statisics ##################

  def winningest_coach(season)
  end 

  def worst_coach(season)
  end 

  def determine_coach_ratios(season)
  end 

  def list_gameteams_from_particular_season(season)
  end 

  def list_games_per_season(season)
  end

  def coach_victory_percentage_hash(games_in_season)
  end 

  def determine_sorted_ratio(hash)
  end

  def most_accurate_team(season)
  end

  def least_accurate_team(season)
  end

  def all_games_by_season
  end

  def team_goals_shots_by_season(season)
  end

  def team_ratios_by_season(hash)
  end

  def team_name(id)
  end

  def most_tackles(season)
  end

  def fewest_tackles(season)
  end

  def all_games_by_season
  end

  def gather_tackles_by_team(season)
  end

 ################## Team Statisics ##################
 
#  def team_info(team_id)
#   selected = teams.select do |team| 
#     team[:team_id] == team_id 
#   end 
#   team = selected[0]
  
#   hash = {
#     "team_id"=> team[:team_id], 
#     "franchise_id"=> team[:franchise_id], 
#     "team_name"=> team[:team_name], 
#     "abbreviation"=> team[:abbreviation], 
#     "link"=> team[:link]
#   }
#   return hash
#   end

#   def best_season(team_id)
#     season_array = ordered_season_array(team_id)
#     season_array.sort.reverse[0][1]
#   end 

#   def worst_season(team_id)
#     season_array = ordered_season_array(team_id)
#     season_array.sort[0][1]
#   end

#   def ordered_season_array(team_id)
#     relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
#     relevant_games = find_corresponding_games_by_gameteam(relevant_game_teams)
#     results_by_season = group_by_season(relevant_games, relevant_game_teams) 
#     season_array = order_list(results_by_season)
#   end

#   def find_relevant_game_teams_by_teamid(team_id)
#     game_teams.find_all { |game_team| game_team[:team_id] == team_id }
#   end 

#   def find_corresponding_games_by_gameteam(relevant_game_teams)
#     games.find_all do |game|
#       relevant_game_teams.each {|game_team| game_team[:game_id] == game[:game_id]} 
#       end
#   end
   
#   def group_by_season(relevant_games, relevant_game_teams)
#     results_by_season = Hash.new{ |hash, key| hash[key] = [] }
#     grouped = relevant_games.group_by { |game| game[:season]}

#     grouped.each do |key, values|
#       values.each do |value|
#       relevant_game_teams.each do |game_team|
#           if value[:game_id] == game_team[:game_id]
#             results_by_season[key] << game_team[:result]
#           end
#         end
#       end
#     end
#     return results_by_season 
#   end 

#   def order_list(hash_seasons)
#     season_array = []
#     hash_seasons.each do |key, value|
#       season_array << [(value.count("WIN").to_f/value.count.to_f), key]
#     end
#     return season_array
#   end

#   def average_win_percentage(team_id)
#     relevant_games = find_relevant_game_teams_by_teamid(team_id)
#     victories = 0 
#     relevant_games.each do |game|
#       if game[:result] == "WIN"
#         victories += 1 
#       end
#     end
  
#     percent = ((victories.to_f)/((relevant_games.count).to_f)).round(2) 
#   end

#   def most_goals_scored(team_id) 
#     relevant_games = find_relevant_game_teams_by_teamid(team_id)
#     goals = create_goals_array(relevant_games)
#     return goals.max 
#   end

#   def fewest_goals_scored(team_id)
#     relevant_games = find_relevant_game_teams_by_teamid(team_id)
#     goals = create_goals_array(relevant_games)
#     return goals.min 
#   end 

#   def create_goals_array(relevant_games)
#     goals = []
#     relevant_games.each {|game| goals << game[:goals]}
#     return goals 
#   end

#   def favorite_opponent(team_id)
#     sorted_array = sorted_array_of_opponent_win_percentages(team_id)
#     result_id = sorted_array.reverse.first.first
#     determine_team_name_based_on_team_id(result_id)
#   end

#   def rival(team_id)
#     sorted_array = sorted_array_of_opponent_win_percentages(team_id)
#     result_id = sorted_array.first.first
#     determine_team_name_based_on_team_id(result_id)
#   end

#   def sorted_array_of_opponent_win_percentages(team_id)
#     relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
#     relevant_games = find_relevant_games_based_on_game_team_hashes(relevant_game_teams)
#     hashed_info = hashed_info(relevant_games, relevant_game_teams, team_id)
#     array = accumulate_hash(hashed_info)
#     sorted = sort_based_on_value(array)
#   end

#   def find_relevant_games_based_on_game_team_hashes(relevant_game_teams)
#     relevant_games = []
#     games.each do |game|
#       relevant_game_teams.each do |game_team|
#         if game[:game_id] == game_team[:game_id]
#           relevant_games << game 
#         end
#       end
#     end
#     return relevant_games
#   end 

#   def hashed_info(relevant_games, relevant_game_teams, team_id)
#     new_hash = Hash.new { |hash, key| hash[key] = [] }
#     relevant_games.each do |game|
#       if game[:away_team_id] != team_id 
#         new_hash[game[:away_team_id]] << determine_game_outcome(game, relevant_game_teams)
#       elsif game[:home_team_id] != team_id
#         new_hash[game[:home_team_id]] << determine_game_outcome(game, relevant_game_teams)
#       end
#     end
#     return new_hash
#   end

#   def determine_game_outcome(game, relevant_game_teams) 
#     relevant_game_teams.each do |game_team|
#       if game_team[:game_id] == game[:game_id]
#         return game_team[:result] 
#       end
#     end
#   end

#   def accumulate_hash(hash)
#     percentage_data = []
#     hash.each {|key, value|percentage_data << [key, ((value.count("WIN").to_f)/(value.count.to_f))]}
#     return percentage_data
#   end

#   def sort_based_on_value(array)
#     array.to_h.sort_by {|key, value| value}
#   end

#   def determine_team_name_based_on_team_id(result_id)
#     selected = teams.select { |team| team[:team_id] == result_id }
#     selected.first[:team_name]
#   end 
end

