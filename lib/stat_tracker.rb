require 'CSV'
require './data/game_teams'
require './data/games'
require './data/teams'

class StatTracker
  attr_reader :games, :teams, :game_teams
 
end

# information needed for each method

# games.csv 
  # highest_total_score - away_goals, home_goals

  # lowest_total_score - away_goals, home_goals

  # count_of_games_by_season - game_id, season

  # average_goals_per_game - away_goals, home_goals

  # average_goals_by_season - season, away_goals, home_goals

# game_teams.csv
  # percentage_home_wins - HoA, result

  # percentage_visitor_wins - HoA, result

  # percentage_ties - result

# teams.csv
  # count_of_teams - team_id

# Multiple csv required
  # best_offense
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, away_team_id, goals

  # worst_offense
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, away_team_id, goals

  # highest_scoring_visitor
    # teams.csv - team_id, teamName
    # games.csv - away_team_id, goals

  # highest_scoring_home_team
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, goals

  # lowest_scoring_visitor
    # teams.csv - team_id, teamName
    # games.csv - away_team_id, goals

  # lowest_scoring_home_team
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, goals

  # winningest_coach
    # game_teams.csv - game_id, team_id, result, head_coach
    # games.csv - game_id, season 

  # worst_coach
    # game_teams.csv - game_id, team_id, result, head_coach
    # games.csv - game_id, season 

  # most_accurate_team
    # game_teams.csv - game_id, team_id, goals, shots
    # games.csv - game_id, season 
    # teams.csv - team_id, teamName

  # least_accurate_team
    # game_teams.csv - game_id, team_id, goals, shots
    # games.csv - game_id, season 
    # teams.csv - team_id, teamName

  # most_tackles
    # game_teams.csv - game_id, team_id, tackles
    # games.csv - game_id, season
    # teams.csv - team_id, teamName

  # least_tackles
    # game_teams.csv - game_id, team_id, tackles
    # games.csv - game_id, season
    # teams.csv - team_id, teamName



