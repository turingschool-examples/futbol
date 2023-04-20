require_relative 'stat_tracker'
class Game 

attr_reader :game_id, 
            :season, 
            :type, 
            :date_time, 
            :away_team_id,
            :home_team_id,
            :away_goals,
            :home_goals, 
            :venue, 
            :venue_link

  def initialize(row)
    @game_id = row[:game_id]
    @season = row[:season]
    @type = row[:type]
    @date_time = row[:date_time]
    @away_team_id = row[:away_team_id]
    @home_team_id = row[:home_team_id]
    @away_goals = row[:away_goals]
    @home_goals = row[:home_goals]
    @venue = row[:venue]
    @venue_link = row[:venue_link]
  end

  # def highest_total_score
  #   method
  # end

  # def lowest_total_score
  #   method
  # end

  # def percentage_home_wins
  #   method
  # end

  # def percentage_visitor_wins
  #   method
  # end

  # def percentage_ties
  #   method
  # end

  # def count_of_games_by_season
  #   method
  # end

  def average_goals_per_game
    method
  end
# # Pseudocode:
#   for each game (away_goals + home_goals)
#   sum all games total goals
#   divide by total number of games
#   (rounded to the nearest 100th)
#   return Float
# Description: Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
# Return Value: Float



  # def average_goals_by_season
  #   method
  # end

# # Pseudocode:
#   for each game (away_goals + home_goals)
#   separate total goals by season
#   create a hash (season => (total goals by season divided by season by count_of_games_by_season)
#   (rounded to the nearest 100th)
#   return Hash

# Description: Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
# Return Value: Hash
end
