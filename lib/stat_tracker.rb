require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'



# Method	Description	Return Value
# count_of_teams	Total number of teams in the data.	Integer

##
# best_offense	Name of the team with the highest average number of goals scored per game across all seasons.	String
#
# Best away team#
## team -> total number of goals across all seasons
# team -> average_num_of_goals


# 3 games

# 3 teams

# Team1 -> avg goal
# Team2 -> avg goal



# worst_offense	Name of the team with the lowest average number of goals scored per game across all seasons.	String
# highest_scoring_visitor	Name of the team with the highest average score per game across all seasons when they are away.	String
# highest_scoring_home_team	Name of the team with the highest average score per game across all seasons when they are home.	String
# lowest_scoring_visitor	Name of the team with the lowest average score per game across all seasons when they are a visitor.	String
# lowest_scoring_home_team	Name of the team with the lowest average score per game across all seasons when they are at home.	String


class StatTracker
    attr_reader :games, :teams, :game_teams

    def self.from_csv(locations)
      games = parse_csv(locations[:games], Game)
      teams = parse_csv(locations[:teams], Team)
      game_teams = parse_csv(locations[:game_teams], GameTeam)
  
      new(games, teams, game_teams)
    end

    def self.parse_csv(filepath, class_object)
      CSV.read(filepath, headers: true, header_converters: :symbol).map do |data|
        class_object.new(data)
      end
    end

    def initialize(games, teams, game_teams)
        @games = games
        @teams = teams
        @game_teams = game_teams
    end

    # Game Statistics
  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.max
  end

  def count_of_teams
    @teams.size
  end

  def best_offense
    goals_by_team = {}
    total_num_of_games_by_team = {};

    @games.each do |game|
      away_team_id = game.away_team_id
      home_team_id = game.home_team_id

      goals_by_team[away_team_id] ||= 0;
      goals_by_team[away_team_id] += game.away_goals;


      goals_by_team[home_team_id] ||= 0;
      goals_by_team[home_team_id] += game.home_goals;

    total_num_of_games_by_team[away_team_id] ||= 0;
    total_num_of_games_by_team[home_team_id] ||= 0;

    total_num_of_games_by_team[home_team_id] += 1;
    total_num_of_games_by_team[away_team_id] += 1;





    end

   team_ids = goals_by_team.keys;


   highest_average = 0
   team_with_highest_average = nil


   team_ids.each do |team_id|
    num_of_games = total_num_of_games_by_team[team_id]
    num_of_goals = goals_by_team[team_id];
    average = num_of_goals.to_f/num_of_games.to_f

    if average > highest_average
      highest_average = average
      team_with_highest_average = team_id
    end

  end
  team_with_highest_average
  
  end
  def worst_offense
    goals_by_team = {}
    total_num_of_games_by_team = {};

    @games.each do |game|
      away_team_id = game.away_team_id
      home_team_id = game.home_team_id

      goals_by_team[away_team_id] ||= 0;
      goals_by_team[away_team_id] += game.away_goals;


      goals_by_team[home_team_id] ||= 0;
      goals_by_team[home_team_id] += game.home_goals;

    total_num_of_games_by_team[away_team_id] ||= 0;
    total_num_of_games_by_team[home_team_id] ||= 0;

    total_num_of_games_by_team[home_team_id] += 1;
    total_num_of_games_by_team[away_team_id] += 1;





    end

   team_ids = goals_by_team.keys;


   lowest_average = 99999999
   team_with_lowest_average = nil


   team_ids.each do |team_id|
    num_of_games = total_num_of_games_by_team[team_id]
    num_of_goals = goals_by_team[team_id];
    average = num_of_goals.to_f/num_of_games.to_f

    if average < lowest_average
      lowest_average = average
      team_with_lowest_average = team_id
    end

  end
  team_with_lowest_average
  
  end



def highest_scoring_visitor

  away_goals_by_team = {}
  total_num_of_away_games_by_team = {};

  @games.each do |game|
    away_team_id = game.away_team_id
    away_goals_by_team[away_team_id] ||= 0;
    away_goals_by_team[away_team_id] += game.away_goals;


    total_num_of_away_games_by_team[away_team_id] ||= 0;
    total_num_of_away_games_by_team[away_team_id] += 1;

  end


  team_ids = away_goals_by_team.keys

  highest_score = 0;
  highest_visitor = nil;

  team_ids.each do |team_id|
    goals = away_goals_by_team[team_id]
    if goals > highest_score
      highest_score = goals
      highest_visitor = team_id
    end

  end

  highest_visitor

end

def lowest_scoring_visitor

  away_goals_by_team = {}
  total_num_of_away_games_by_team = {};

  @games.each do |game|
    away_team_id = game.away_team_id
    away_goals_by_team[away_team_id] ||= 0;
    away_goals_by_team[away_team_id] += game.away_goals;


    total_num_of_away_games_by_team[away_team_id] ||= 0;
    total_num_of_away_games_by_team[away_team_id] += 1;

  end


  team_ids = away_goals_by_team.keys

  lowest_score = 9999; # Change this to a hight number (infiginity)
  lowest_visitor = nil;

  team_ids.each do |team_id|
    goals = away_goals_by_team[team_id]
    if goals < lowest_score
      lowest_score = goals
      lowest_visitor = team_id
    end

  end

  lowest_visitor

end


def lowest_scoring_home_team

  home_goals_by_team = {}
  total_num_of_home_games_by_team = {};

  @games.each do |game|
    home_team_id = game.home_team_id
    home_goals_by_team[home_team_id] ||= 0;
    home_goals_by_team[home_team_id] += game.home_goals;


    total_num_of_home_games_by_team[home_team_id] ||= 0;
    total_num_of_home_games_by_team[home_team_id] += 1;

  end


  team_ids = home_goals_by_team.keys

  lowest_score = 9999; # Change this to a hight number (infiginity)
  lowest_home = nil;

  team_ids.each do |team_id|
    goals = home_goals_by_team[team_id]
    if goals < lowest_score
      lowest_score = goals
      lowest_home = team_id
    end

  end

  lowest_home

end



def highest_scoring_home_team

  home_goals_by_team = {}
  total_num_of_home_games_by_team = {};

  @games.each do |game|
    home_team_id = game.home_team_id
    home_goals_by_team[home_team_id] ||= 0;
    home_goals_by_team[home_team_id] += game.home_goals;


    total_num_of_home_games_by_team[home_team_id] ||= 0;
    total_num_of_home_games_by_team[home_team_id] += 1;

  end


  team_ids = home_goals_by_team.keys

  highest_score = 0; # Change this to a hight number (infiginity)
  highest_home = nil;

  team_ids.each do |team_id|
    goals = home_goals_by_team[team_id]
    if goals > highest_score
      highest_score = goals
      highest_home = team_id
    end

  end

  highest_home
end






  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.min
  end

  def percentage_home_wins
    total_games = @games.size
    home_wins = @games.count { |game| game.home_goals > game.away_goals }
    (home_wins.to_f / total_games).round(2)
  end

  def percentage_visitor_wins
    total_games = @games.size
    visitor_wins = @games.count { |game| game.away_goals > game.home_goals }
    (visitor_wins.to_f / total_games).round(2)
  end

  def percentage_ties
    total_games = @games.size
    ties = @games.count { |game| game.away_goals == game.home_goals }
    (ties.to_f / total_games).round(2)
  end

  def count_of_games_by_season
    @games.group_by { |game| game.season }.transform_values(&:count)
  end

  def average_goals_per_game
    total_goals = @games.sum { |game| game.away_goals + game.home_goals }
    (total_goals.to_f / @games.size).round(2)
  end

  def average_goals_by_season
    season_goals = @games.group_by { |game| game.season }
    season_goals.transform_values do |games|
      total_goals = games.sum { |game| game.away_goals + game.home_goals }
      (total_goals.to_f / games.size).round(2)
    end
  end

  # # League Statistics
  # def count_of_teams
  #   # count_of_teams
  #   # Count the total number of unique teams.
  #   # Count the distinct team ids in the teams data.

  # end

  # def best_offense
  # # best_offense
  # # Find the team with the highest average number of goals scored per game.
  # # Calculate the average goals per game for each team and find the team with the highest average.
  
  # end

  # def worst_offense
  #   # worst_offense
  #   # Find the team with the lowest average number of goals scored per game.
  #   # Calculate the average goals per game for each team and find the team with the lowest average.
  # end

  # def highest_scoring_visitor
  #   # highest_scoring_visitor
  #   # Find the team with the highest average score per game when they are away.
  #   # Filter the games where the team is away, calculate their average score per game, and find the team with the highest average.
  # end

  # def highest_scoring_home_team
  #   # highest_scoring_home_team
  #   # Find the team with the highest average score per game when they are home.
  #   # Filter the games where the team is home, calculate their average score per game, and find the team with the highest average.  #  implementation here
  # end

  # def lowest_scoring_visitor
  #   # lowest_scoring_visitor
  #   # Find the team with the lowest average score per game when they are a visitor.
  #   # Filter the games where the team is away, calculate their average score per game, and find the team with the lowest average.
  # end

  # def lowest_scoring_home_team
  #   # lowest_scoring_home_team
  #   # Find the team with the lowest average score per game when they are at home.
  #   # Filter the games where the team is home, calculate their average score per game, and find the team with the lowest average.
  # end

  # # Season Statistics
  # def winningest_coach
  #   # winningest_coach
  #   # Find the coach with the best win percentage for the season.
  #   # Group the games by season and head coach, calculate the win percentage for each coach, and find the one with the highest percentage.
  # end

  # def worst_coach
  #   # worst_coach
  #   # Find the coach with the worst win percentage for the season.
  #   # Group the games by season and head coach, calculate the win percentage for each coach, and find the one with the lowest percentage.
  # end

  # def most_accurate_team
  #   # most_accurate_team
  #   # Find the team with the best ratio of shots to goals for the season.
  #   # Group the games by season and team, calculate the ratio of shots to goals for each team, and find the team with the highest ratio.
  # end

  # def least_accurate_team
  #   # least_accurate_team
  #   # Find the team with the worst ratio of shots to goals for the season.
  #   # Group the games by season and team, calculate the ratio of shots to goals for each team, and find the team with the lowest ratio.
  # end

  # def most_tackles
  #   # most_tackles
  #   # Find the team with the most tackles in the season.
  #   # Group the games by season and team, sum up the tackles for each team, and find the team with the highest total tackles.
  # end

  # def fewest_tackles
  #   # fewest_tackles
  #   # Find the team with the fewest tackles in the season.
  #   # Group the games by season and team, sum up the tackles for each team, and find the team with the lowest total tackles.
  # end
end
