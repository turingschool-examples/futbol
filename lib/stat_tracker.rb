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

  #League Statistics
  def count_of_teams
    @teams.count
  end

#Methods between lines 123 & 150 are used with best_offense/worst_offense
#calculating goals across all seasons for a team
  def best_offense
    @teams.max_by do |team|
      average_goals(team)
    end.team_name
  end

  def worst_offense
    @teams.min_by do |team|
      average_goals(team)
    end.team_name
  end
  #average goals across all games
  def average_goals(team)
    all_games = team_games(team)
    return 0 if all_games.empty?
    total_goals(all_games)/all_games.count.to_f
  end
  #finds all games a team plays in, and returns that array
  def team_games(team)
    @game_teams.find_all do |game|
      game.team_id == team.team_id
    end
  end
  #sums the goals for all games of a team
  def total_goals(all_games)
    all_games.sum {|game| game.goals}
  end

  #Lines 153 to ??? use these methods to find teh highest/lowest scoring teams
  #based on being the home or away team
  def highest_scoring_visitor
    @teams.max_by do |team|
      visiting_average_goals(team)
    end.team_name
  end

  def visiting_team_games(team)
    @game_teams.find_all do |game|
      game.team_id == team.team_id && game.h_o_a == "away"
    end
  end

  def visiting_average_goals(team)
    visiting_games = visiting_team_games(team)
    return 0 if visiting_games.empty?
    total_goals(visiting_games)/visiting_games.count.to_f
  end

  def highest_scoring_home_team
    @teams.max_by do |team|
      home_average_goals(team)
    end.team_name
  end

  def home_team_games(team)
    @game_teams.find_all do |game|
      game.team_id == team.team_id && game.h_o_a == "home"
    end
  end

  def home_average_goals(team)
    home_games = home_team_games(team)
    return 0 if home_games.empty?
    total_goals(home_games)/home_games.count.to_f
  end

  def lowest_scoring_visitor
    @teams.min_by do |team|
      visiting_average_goals(team)
    end.team_name
  end

  def lowest_scoring_home_team
    @teams.min_by do |team|
      home_average_goals(team)
    end.team_name
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
