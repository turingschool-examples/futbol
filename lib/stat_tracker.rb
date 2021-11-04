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

  # Game Statistics Methods
  def highest_total_score
    game_score = @games.map { |game| game.away_goals + game.home_goals }
    game_score.max
  end

  def lowest_total_score
    game_score = @games.map { |game| game.away_goals + game.home_goals }
    game_score.min
  end

  def percentage_visitor_wins
    visitor_wins = []
    @games.each do |game|
      visitor_wins.push(game) if game.away_goals > game.home_goals
    end
    (visitor_wins.count.to_f / @games.count.to_f).round(2)
  end

  def percentage_home_wins
    home_wins = []
    @games.each do |game|
      home_wins.push(game) if game.home_goals > game.away_goals
    end
    (home_wins.count.to_f / @games.count.to_f).round(2)
  end

  def percentage_ties
    tie_games = []
    @games.each do |game|
      tie_games.push(game) if game.home_goals == game.away_goals
    end
    (tie_games.count.to_f / @games.count.to_f).round(2)
  end

  # A hash with season names (e.g. 20122013) as keys and counts of games as values
  def count_of_games_by_season
    count_of_games_by_season = Hash.new(0)
    games_by_season = @games.group_by { |game| game.season }
    games_by_season.keys.each do |season|
      count_of_games_by_season[season] = games_by_season[season].length
    end
    count_of_games_by_season
  end

  # Average number of goals scored in a game across all seasons including
  # both home and away goals (rounded to the nearest 100th) - float
  def average_goals_per_game
    total_goals = @games.map { |game| game.home_goals + game.away_goals }
    avg_goals_per_game = (total_goals.sum.to_f / total_goals.length.to_f).round(2)
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

  # League Statistics
  def count_of_teams
    @teams.count
  end

  # Methods between lines 123 & 150 are used with best_offense/worst_offense
  # calculating goals across all seasons for a team
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

  # average goals across all games
  def average_goals(team)
    all_games = team_games(team)
    return 0 if all_games.empty?

    total_goals(all_games) / all_games.count.to_f
  end

  # finds all games a team plays in, and returns that array
  def team_games(team)
    @game_teams.find_all do |game|
      game.team_id == team.team_id
    end
  end

  # sums the goals for all games of a team
  def total_goals(all_games)
    all_games.sum { |game| game.goals }
  end

  #Lines 153 to 200 use these methods to find teh highest/lowest scoring teams
  #based on being the home or away team
  def highest_scoring_visitor
    @teams.max_by do |team|
      visiting_average_goals(team)
    end.team_name
  end

  def visiting_team_games(team)
    @game_teams.find_all do |game|
      game.team_id == team.team_id && game.h_o_a == 'away'
    end
  end

  def visiting_average_goals(team)
    visiting_games = visiting_team_games(team)
    return 0 if visiting_games.empty?

    total_goals(visiting_games) / visiting_games.count.to_f
  end

  def highest_scoring_home_team
    @teams.max_by do |team|
      home_average_goals(team)
    end.team_name
  end

  def home_team_games(team)
    @game_teams.find_all do |game|
      game.team_id == team.team_id && game.h_o_a == 'home'
    end
  end

  def home_average_goals(team)
    home_games = home_team_games(team)
    return 0 if home_games.empty?

    total_goals(home_games) / home_games.count.to_f
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


  #Team Statistics
  def team_info(team_id)
    team = find_team(team_id)
    {
      team_id: team.team_id,
      franchise_id: team.franchise_id,
      team_name: team.team_name,
      abbreviation: team.abbreviation,
      stadium: team.stadium,
      link: team.link
    }
    # categories = team.keys
    # info = team.values
    # Hash[categories.zip(info)]
  end

  def find_team(team_id)
    @teams.find {|team| team.team_id == team_id}
  end

  def best_season(team_id)
    seasons.max_by do |season|
      team_season_win_percentage(team_id, season) #pass in two arguments and include the season?
    end
  end

  def seasons
    @games.map {|game| game.season}.uniq
  end

  def team_season_win_percentage(team_id, season)
    return 0 if team_games_by_season(team_id, season).count == 0
    season_wins(team_id, season).count/team_games_by_season(team_id, season).count.to_f
  end

  #this is going through the games and not game_teams where the wins aare saved
  def team_games_by_season(team_id, season)
    seasons_games = games_in_season(season)
    seasons_games.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
  end

  def season_wins(team_id, season)
    @game_teams.find_all do |game_team|
      game_team.team_id == team_id && game_team.result == "WIN"
    end
  end

  def worst_season(team_id)
    seasons.min_by do |season|
      team_season_win_percentage(team_id, season)
    end 
  end

  def average_win_percentage(team_id)
    total = @games.size
    away_games = @games.find_all do |game|
      team_id == game.away_team_id && game.away_goals > game.home_goals
    end.size

    home_games = @games.find_all do |game|
      team_id == game.home_team_id && game.away_goals < game.home_goals
    end.size
    percentage = (away_games + home_games) / total.to_f * 100

    percentage.round
  end

  def most_goals_scored(team_id)
    total = []
    away_games = @games.find_all do |game|
      team_id == game.away_team_id
    end
    home_games = @games.find_all do |game|
      team_id == game.home_team_id
    end
    total << away_games = away_games.map { |game| game.away_goals }.max
    total << home_games = home_games.map { |game| game.home_goals }.max
    total.max
  end

  def fewest_goals_scored(team_id)
    total = []
    away_games = @games.find_all do |game|
      team_id == game.away_team_id
    end
    home_games = @games.find_all do |game|
      team_id == game.home_team_id
    end
    total << away_games = away_games.map { |game| game.away_goals }.min
    total << home_games = home_games.map { |game| game.home_goals }.min
    total.min
  end

  def favorite_opponent; end

  def rival; end

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

  def worst_coach; end

  def most_accurate_team; end

  def least_accurate_team; end

  def games_in_season(season)
    games_in_season = @games.find_all { |game| game.season == season }
  end

  # helper method to collect all game_teams in a given season
  def game_teams_in_season(season)
    # collect all games is selected season. games.csv
    # collect all game_team entires with corresponding game_ids - game_teams.csv
    games_in_season = games_in_season(season)
    game_ids_in_season = games_in_season.map { |game| game.game_id }
    # only include game_team if it's game_id is in list of correct game ids
    @game_teams.find_all do |game_team|
      game_ids_in_season.include?(game_team.game_id)
    end
  end

  # return an array of team names from an array of team objects, or a single team name if only one given
  def get_teams_from_game_teams(game_teams)
    # if single team, return single value. Else return array of values.
    if game_teams.instance_of?(Array)
      # get team ids from selected game_teams, and use this to gather the team names.
      team_ids = game_teams.map { |game_team| game_team.team_id }
      @teams.select { |team| team_ids.include?(team.team_id) } # this can be faster with a hash.

    else
      # get team id from selected game_team, and use this to gather the team name.
      team_id = game_teams.team_id
      @teams.select { |team| team.team_id == team_id } # this can be faster with a hash

    end
  end

  # Name of the Team with the most tackles in the season	- String
  def most_tackles(season)
    game_teams_in_season = game_teams_in_season(season)
    # get game_team object with most tackles - game_teams.csv
    max_tackles_game_teams = game_teams_in_season.max_by do |game_team|
      game_team.tackles
    end
    teams = get_teams_from_game_teams(max_tackles_game_teams)
    team_names = teams.map { |team| team.team_name }
    # return sigle name if only one item.
    if team_names.length == 1
      team_names[0]
    else
      team_names
    end
  end

  # Name of the Team with the fewest tackles in the season	- String
  def fewest_tackles(season)
    game_teams_in_season = game_teams_in_season(season)
    # get game_team object with most tackles - game_teams.csv
    min_tackles_game_teams = game_teams_in_season.min_by do |game_team|
      game_team.tackles
    end
    teams = get_teams_from_game_teams(min_tackles_game_teams)
    team_names = teams.map { |team| team.team_name }
    # return sigle name if only one item.
    if team_names.length == 1
      team_names[0]
    else
      team_names
    end
  end
end
