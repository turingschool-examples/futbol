require 'csv'
require_relative './teams'
require_relative './game_teams'
require_relative './games'

class StatTracker
  attr_accessor :games, :teams, :game_teams

  def initialize()
    @games = Hash.new(0)
    @teams = Hash.new(0)
    @game_teams = Hash.new(0)
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new()
    rows = CSV.read(locations[:teams], headers: true)
    rows.each do |row|
      team = Teams.new(row)
      stat_tracker.teams[team.team_id] = team
    end

    rows = CSV.read(locations[:games], headers: true)
    rows.each do |row|
      game = Games.new(row)
      stat_tracker.games[game.game_id] = game
    end

    rows = CSV.read(locations[:game_teams], headers: true)
    rows.each do |row|
      game_team = GameTeams.new(row)
      combo_id = game_team.game_id + '_' + game_team.team_id
      stat_tracker.game_teams[combo_id] = game_team
    end
    return stat_tracker
  end

  #Game Statistics Methods
  def highest_total_score
    game_score = @games.values.map {|game| game.away_goals + game.home_goals}
    game_score.max
  end

  def lowest_total_score
    game_score = @games.values.map {|game| game.away_goals + game.home_goals}
    game_score.min
  end

  def percentage_visitor_wins
    visitor_wins = []
    @games.values.each do |game|
      if game.away_goals > game.home_goals
        visitor_wins.push(game)
      end
    end
    (visitor_wins.count.to_f / @games.values.count.to_f).round(2)
  end

  def percentage_home_wins
    home_wins = []
    @games.values.each do |game|
      if game.home_goals > game.away_goals
        home_wins.push(game)
      end
    end
    (home_wins.count.to_f / @games.values.count.to_f).round(2)
  end

  def percentage_ties
    tie_games = []
    @games.values.each do |game|
      if game.home_goals == game.away_goals
        tie_games.push(game)
      end
    end
    (tie_games.count.to_f / @games.values.count.to_f).round(2)
  end

  # A hash with season names (e.g. 20122013) as keys and counts of games as values
  def count_of_games_by_season
    count_of_games_by_season = Hash.new(0)
    games_by_season = @games.values.group_by{|game| game.season}
    games_by_season.keys.each do |season|
      count_of_games_by_season[season] = games_by_season[season].length
    end
    return count_of_games_by_season
  end


  # Average number of goals scored in a game across all seasons including
  # both home and away goals (rounded to the nearest 100th) - float
  def avgerage_goals_per_game
    total_goals = @games.values.map{|game| game.home_goals + game.away_goals}
    avg_goals_per_game = (total_goals.sum.to_f/total_goals.length.to_f).round(2)
  end

  # Average number of goals scored in a game organized in a hash
  # with season names (e.g. 20122013) as keys and a float
  # representing the average number of goals in a game for that season
  # as values (rounded to the nearest 100th)	- Hash

  def avgerage_goals_per_season
  #   avg_goals_per_season = Hash.new(0)
  #   games_by_season = @games.group_by do|game|
  #     game.season
  #   end
  #   games_by_season.keys.each do |season|
  #     goals_by_season = games_by_season[season].map{|game| game.home_goals + game.away_goals}
  #     avg_goals_per_season[season] = (goals_by_season.sum.to_f / goals_by_season.length.to_f).round(2)
  #   end
  #   return avg_goals_per_season
  end

   def highest_scoring_visitor





  end

  def worst_offense





  end
  def highest_scoring_home_team





  end
  def lowest_scoring_visitor





  end
  def lowest_scoring_home_team





  end
  def team_info





  end
  def best_season





  end
  def worst_season





  end
  def average_win_percentage





  end
  def most_goals_scored





  end
  def fewest_goals_scored





  end
  def favorite_opponent





  end
  def rival





  end

  #### Season
  def winningest_coach





  end
  def worst_coach





  end
  def most_accurate_team





  end
  def least_accurate_team





  end

  # Name of the Team with the most tackles in the season	- String
  def most_tackles(season)
    # collect game_id by season - games.csv
    # get cooresponding # tackles from game_teams.csv
    # get team ID from game_teams.csv
    # get team name from team ID
    games_by_season = @games.group_by{|game| game.season}
    games_by_season.each do |season, games|
      games.each do |game|
        @game_teams[game.game_id].tackles
      end
    end




  end

  # Name of the Team with the fewest tackles in the season	- String
  def fewest_tackles(season)





  end
end
