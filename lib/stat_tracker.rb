require 'csv'

class StatTracker
  
  def initialize(locations)
    @locations = locations
    @games_data = CSV.read(@locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(@locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(@locations[:game_teams], headers: true, header_converters: :symbol)
    @game_statistics = GameStatistics.new(@games_data, @game_teams_data)
    @league_statistics = LeagueStatistics.new(@teams_data, @game_teams_data)
    @season_statistics = SeasonStatistics.new(@teams_data, @games_data, @game_teams_data)
    @team_statistics = TeamStatistics.new(@teams_data, @games_data, @game_teams_data)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # Game statistics 
  def highest_total_score
    @game_statistics.highest_total_score
  end

  def lowest_total_score
    @game_statistics.lowest_total_score
  end

  def percentage_home_wins
    @game_statistics.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_statistics.percentage_visitor_wins
  end

  def percentage_ties
    @game_statistics.percentage_ties
  end

  def count_of_games_by_season    
    @game_statistics.count_of_games_by_season
  end

  def average_goals_per_game
    @game_statistics.average_goals_per_game
  end

  def average_goals_by_season
    @game_statistics.average_goals_by_season
  end

  #League Statistics
  
  def count_of_teams
    @league_statistics.count_of_teams
  end

  def best_offense 
    @league_statistics.best_offense
  end 

  def worst_offense
    @league_statistics.worst_offense
  end

  def highest_scoring_visitor
    @league_statistics.highest_scoring_visitor
  end

  def highest_scoring_home_team  
    @league_statistics.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_statistics.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_statistics.lowest_scoring_home_team
  end
  
  # # Season Statistics
  def winningest_coach(season)
    @season_statistics.winningest_coach(season)
  end

  def worst_coach(season)
    @season_statistics.worst_coach(season)
  end

  def most_accurate_team(season)
    @season_statistics.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @season_statistics.least_accurate_team(season)
  end

  def most_tackles(season)
    @season_statistics.most_tackles(season)
  end

  def fewest_tackles(season)
    @season_statistics.fewest_tackles(season)
  end

  # Team Statistics

  def team_info(given_team_id)
    @team_statistics.team_info(given_team_id)
  end

  def best_season(given_team_id)
    @team_statistics.best_season(given_team_id)
  end

  def worst_season(given_team_id)
    @team_statistics.worst_season(given_team_id)
  end

  def average_win_percentage(given_team_id)
    @team_statistics.average_win_percentage(given_team_id)
  end

  def most_goals_scored(given_team_id)
    @team_statistics.most_goals_scored(given_team_id)
  end

  def fewest_goals_scored(given_team_id)
    @team_statistics.fewest_goals_scored(given_team_id)
  end

  def favorite_opponent(given_team_id)
    @team_statistics.favorite_opponent(given_team_id)
  end

  def rival(given_team_id)
    @team_statistics.rival(given_team_id)
  end
end

  #helper methods
  #delete?
  # def find_all_team_games(given_team_id)
  #   away_games_by_team(given_team_id) + home_games_by_team(given_team_id)
  # end

  # def away_games_by_team(given_team_id)
  #   @games_data.find_all do |team|
  #     team[:away_team_id] == given_team_id.to_s
  #   end
  # end

  # def home_games_by_team(given_team_id)
  #   @games_data.find_all do |team|
  #     team[:home_team_id] == given_team_id.to_s
  #   end
  # end

  # def find_team_name_by_id(id_number)
  #   team_name = nil
  #   @teams_data.each do |row|
  #     team_name = row[:teamname] if row[:team_id] == id_number.to_s
  #   end
  #   team_name
  # end

