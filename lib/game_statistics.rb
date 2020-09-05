
class GameStatistics
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals

  def initialize(data)
    @game_id = data[:game_id]
    @season = data[:season]
    @type = data[:type]
    @date_time = data[:date_time]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @away_goals = data[:away_goals]
    @home_goals = data[:home_goals]
    # require "pry"; binding.pry
  end

  def game_total_score
    # total_score = []
    stat_tracker = StatTracker.game_stats

    stat_tracker
    # total_score << (@home_goals + @away_goals)
    require "pry"; binding.pry
  end

  def highest_total_score
    # require "pry"; binding.pry

  end

end

#highest_total_score:
#games.csv
#game with highest total score
#11

#lowest_total_score:
#games.csv
#game with lowest total score
#0

#percentage_home_wins
#game_teams.csv
#game_id, team_id, HoA => home, result?
# home_games = selectwhated (game_teams, :hoa, 'home')
# home_games_won = select(home_games, :result, 'WIN')
# 0.44

#percentage_visitor_wins
#game_teams.csv
#game_id, team_id, HoA => away, result?
#away_games = selectwhated (game_teams, :hoa, 'away')
# away_games_won = select(away_games, :result, 'WIN')
# 0.36

#percentage_ties
#game_teams.csv
#game_id, team_id, HoA => , result? => TIE
#tie_games = selectwhated (game_teams')
# away_games_won = select(away_games, :result, 'TIE')
# 0.20

#count_of_games_by_season
#games.csv
#HASH
#season names = keys
#counts of games(game_id) = values
#expected = { 
# => "20122013"=>806,       "20162017"=>1317,       "20142015"=>1319,       "20152016"=>1321,       "20132014"=>1323,       "20172018"=>1355     }

#average_goals_per_game
#games.csv
#sum away and home goals
#divide sum by all games
#1/19/13 - 6/8/18
#round(2)
#4.22

#average_goals_by_season
#games.csv
#hash
#season names = keys
#avg num goals for that season float round(2)
#expected = {       "20122013"=>4.12,       "20162017"=>4.23,       "20142015"=>4.14,       "20152016"=>4.16,       "20132014"=>4.19,       "20172018"=>4.44     }
