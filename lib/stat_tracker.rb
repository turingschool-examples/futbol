require 'csv'
require_relative './teams'
require_relative './game_teams'
require_relative './games'

class StatTracker
  attr_accessor :games, :teams, :game_teams

  def initialize(locations)
    @games = create_games(locations[:games])
    @teams = create_teams(locations[:teams])
    @game_teams = create_game_teams(locations[:game_teams])
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new(locations)
  end

  def create_teams(teams_data)
    rows = CSV.read(teams_data, headers: true)
    rows.map do |row|
      Teams.new(row)
    end
  end

  def create_games(games_data)
    rows = CSV.read(games_data, headers: true)
    rows.map do |row|
      Games.new(row)
    end
  end

  def create_game_teams(game_teams_data)
    rows = CSV.read(game_teams_data, headers: true)
    rows.map do |row|
      GameTeams.new(row)
    end
  end

  #Game Statistics Methods
  def highest_total_score
    game_score = @games.map {|game| game.away_goals + game.home_goals}
    game_score.max
  end

  def lowest_total_score
    game_score = @games.map {|game| game.away_goals + game.home_goals}
    game_score.min
  end

  def percentage_visitor_wins
    visitor_wins = []
    @games.each do |game|
      if game.away_goals > game.home_goals
        visitor_wins.push(game)
      end
    end
    (visitor_wins.count.to_f / @games.count.to_f).round(2)
  end

  def percentage_home_wins
    home_wins = []
    @games.each do |game|
      if game.home_goals > game.away_goals
        home_wins.push(game)
      end
    end
    (home_wins.count.to_f / @games.count.to_f).round(2)
  end

  def percentage_ties
    tie_games = []
    @games.each do |game|
      if game.home_goals == game.away_goals
        tie_games.push(game)
      end
    end
    (tie_games.count.to_f / @games.count.to_f).round(2)
  end

  # A hash with season names (e.g. 20122013) as keys and counts of games as values
  def count_of_games_by_season
    count_of_games_by_season = Hash.new(0)
    games_by_season = @games.group_by{|game| game.season}
    games_by_season.keys.each do |season|
      count_of_games_by_season[season] = games_by_season[season].length
    end
    return count_of_games_by_season
  end


  # Average number of goals scored in a game across all seasons including
  # both home and away goals (rounded to the nearest 100th) - float
  def average_goals_per_game
    total_goals = @games.map{|game| game.home_goals + game.away_goals}
    avg_goals_per_game = (total_goals.sum.to_f/total_goals.length.to_f).round(2)
  end

  # Average number of goals scored in a game organized in a hash
  # with season names (e.g. 20122013) as keys and a float
  # representing the average number of goals in a game for that season
  # as values (rounded to the nearest 100th)	- Hash

  def average_goals_per_season
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
    # games_won = []
    # @games.each do|game|
    #   if game.game.home_goals > game.away_goals
    #     games_won.push(game)
    #   end
    #   games_won.group_by
    # end



  end
  def worst_coach





  end
  def most_accurate_team





  end
  def least_accurate_team





  end

  # Name of the Team with the most tackles in the season	- String
  def most_tackles(season)
    # collect all games is selected season. games.csv
    # collect all game_team entires with corresponding game_ids - game_teams.csv
    # get game_team object with most tackles - game_teams.csv
    # get team ID from this game_team object
    # get team name from team ID - teams.csv

    games_in_season = @games.find_all{ |game| game.season == season }
    game_ids_in_season = games_in_season.map { |game| game.game_id }
    # only include game_team if it's game_id is in list of correct game ids
    game_teams_in_season = @game_teams.find_all do |game_team|
      game_ids_in_season.include?(game_team.game_id)
    end
    # find all game_teams with max number of tackles
    max_tackles_game_teams = game_teams_in_season.max_by do |game_team|
      game_team.tackles
    end

    # if single team, return single value. Else return array of values.
    if max_tackles_game_teams.class == Array
      # get team ids from selected game_teams, and use this to gather the team names.
      max_tackles_team_ids =  max_tackles_game_teams.map { |game_team| game_team.team_id}
      max_tackles_teams = max_tackles_team_ids.map { |team_id| @teams[team_id]}
      max_tackles_team_names = max_tackles_teams.map { |team| team.team_name}
      return max_tackles_team_names
    else
      # get team id from selected game_team, and use this to gather the team name.
      max_tackles_team_id =  max_tackles_game_teams.team_id
      max_tackles_team_name = @teams.select{|team| team.team_id == max_tackles_team_id}[0].team_name
      return max_tackles_team_name
    end
  end

  # Name of the Team with the fewest tackles in the season	- String
  def fewest_tackles(season)





  end
end
