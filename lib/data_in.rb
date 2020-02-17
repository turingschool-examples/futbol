class DataIn
  @@files = {
              games: './data/games.csv',
              teams: './data/teams.csv',
              game_teams: './data/game_teams.csv'
            }
  def self.csv_in(files)
    CSV.read(files[:teams])

  end

end

class Teams



end

module RecordRetrieve
  CSV_OPTIONS = {
                headers: true,
                converters: :all
                }
  def retrieve_entries_matching(sources, entries,  select_headers = nil)
    matching_rows = []
    CSV.foreach('./data/teams.csv', CSV_OPTIONS) { |row| matching_rows << row.to_hash if row_has_value?(entries, row) }
    matching_rows
  end



def row_has_value?(entries, row)
  entries.any? { |header, value| row[header] == value }
end


  def entries_with_headers(file, headers)
    entries = []
    CSV.foreach('./data/teams.csv', CSV_OPTIONS) {|row| entries << row if  }
  end

def highest_total_score
  headers_i_want = {
                 headers: ["game_id","home_goals","away_goals"]
                }
  build_table(data_i_want)

  games.max_by {|game| game.home_goals + game.away_goals }
end


# <--------------- CSV File Headers --------------->
# Games:
# game_id   season   type   date_time   away_team_id   home_team_id   away_goals   home_goals   venue   venue_link
#
# Teams:
# team_id   franchiseId   teamName   abbreviation   Stadium   link
#
# Game Teams:
# game_id   team_id   HoA   result   settled_in   head_coach   goals   shots   tackles   pim   powerPlayOpportunities   powerPlayGoals   faceOffWinPercentage   giveaways   takeaways


# <--------------- Game Stats --------------->
def highest_total_score
  #Highest sum of the winning and losing teams’ scores
  # games.max_by {|game| game.home_goals + game.away_goals }
  #Integer
end
def lowest_total_score
  # Lowest sum of the winning and losing teams’ scores
  # games.min_by {|game| game.home_goals + game.away_goals }
  # Returns Integer
end
def biggest_blowout
  # Highest difference between winner and loser
  # Returns Integer
end
def percentage_home_wins
  # Percentage of games that a home team has won (rounded to the nearest 100th)
  # Returns Float
end
def percentage_visitor_wins
  # Percentage of games that a visitor has won (rounded to the nearest 100th)
  # Returns Float
end
def percentage_ties
  # Percentage of games that has resulted in a tie (rounded to the nearest 100th)
  # Returns Float
end
def count_of_games_by_season
  # A hash with season names (e.g. 20122013) as keys and counts of games as values
  # Returns Hash
end
def average_goals_per_game
  # Average number of goals scored in a game across all seasons including both
  # home and away goals (rounded to the nearest 100th)
  # Returns Float
end
def average_goals_by_season
  # Average number of goals scored in a game organized in a hash with season
   # names (e.g. 20122013) as keys and a float representing the average number
   # of goals in a game for that season as a key (rounded to the nearest 100th)
  # Returns Hash
end

  # <--------------- League Stats --------------->
def count_of_teams
  # Total number of teams in the data.
  # Returns Integer
end
def best_offense
  # Name of the team with the highest average number of goals scored per game across all seasons.
  # Returns String
end
def worst_offense
  # Name of the team with the lowest average number of goals scored per game across all seasons.
  # Returns String
end
def best_defense
  # Name of the team with the lowest average number of goals allowed per game across all seasons.
  # Returns String
end
def worst_defense
  # Name of the team with the highest average number of goals allowed per game across all seasons.
  # Returns String
end
def highest_scoring_visitor
  # Name of the team with the highest average score per game across all seasons when they are away.
  # Returns String
end
def highest_scoring_home_team
  # Name of the team with the highest average score per game across all seasons when they are home.
  # Returns String
end
def lowest_scoring_visitor
  # Name of the team with the lowest average score per game across all seasons when they are a visitor.
  # Returns String
end
def lowest_scoring_home_team
  # Name of the team with the lowest average score per game across all seasons when they are at home.
  # Returns String
end
def winningest_team
  # Name of the team with the highest win percentage across all seasons.
  # Returns String
end
def best_fans
  # Name of the team with biggest difference between home and away win percentages.
  # Returns String
end
def worst_fans
  # List of names of all teams with better away records than home records.
  # Returns Array
end

  # <--------------- Season Stats --------------->
def biggest_bust
  # Name of the team with the biggest decrease between regular season and postseason win percentage.
  # Returns String
end
def biggest_surprise
  # Name of the team with the biggest increase between regular season and postseason win percentage.
  # Returns String
end
def winningest_coach
  # Name of the Coach with the best win percentage for the season
  # Returns String
end
def worst_coach
  # Name of the Coach with the worst win percentage for the season
  # Returns String
end
def most_accurate_team
  # Name of the Team with the best ratio of shots to goals for the season
  # Returns String
end
def least_accurate_team
  # Name of the Team with the worst ratio of shots to goals for the season
  # Returns String
end
def most_tackles
  # Name of the Team with the most tackles in the season
  # Returns String
end
def fewest_tackles
  # Name of the Team with the fewest tackles in the season
  # Returns String
end

  # <--------------- Team Stats --------------->

def team_info
  # A hash with key/value pairs for the following attributes: team_id, franchise_id, team_name, abbreviation, and link
  # Returns Hash
end
def best_season
  # Season with the highest win percentage for a team.
  # Returns String
end
def worst_season
  # Season with the lowest win percentage for a team.
  # Returns String
end
def average_win_percentage
  # Average win percentage of all games for a team.
  # Returns Float
end
def most_goals_scored
  # Highest number of goals a particular team has scored in a single game.
  # Returns Integer
end
def fewest_goals_scored
  # Lowest numer of goals a particular team has scored in a single game.
  # Returns Integer
end
def favorite_opponent
  # Name of the opponent that has the lowest win percentage against the given team.
  # Returns String
end
def rival
  # Name of the opponent that has the highest win percentage against the given team.
  # Returns String
end
def biggest_team_blowout
  # Biggest difference between team goals and opponent goals for a win for the given team.
  # Returns Integer
end
def worst_loss
  # Biggest difference between team goals and opponent goals for a loss for the given team.
  # Returns Integer
end
def head_to_head
  # Record (as a hash - win/loss) against all opponents with the opponents’ names as keys and the win percentage against that opponent as a value.
  # Returns Hash
end
def seasonal_summary
  # For each season that the team has played, a hash that has two keys (:regular_season and :postseason), that each point to a hash with the following keys: :win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against.
  # Returns Hash
end
