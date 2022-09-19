require 'csv'
require_relative 'team_stats'
require_relative 'season_stats'

class StatTracker
  include TeamStatistics
  include SeasonStatistics
  include GameStats

  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.read locations[:games], headers: true, header_converters: :symbol
    teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    StatTracker.new(games, teams, game_teams)
  end

  def team_name(team_id)
    name = @teams.filter_map {|row| row[:teamname] if row[:team_id].to_i == team_id }
    return name[0]
  end

  def best_offense
    best = average_goals.max_by {|key,value| value}
    hash = Hash.new
    @teams.map do |row|
      team_id = row[:team_id]
      team_name = row[:teamname]
      hash[team_id] = team_name
    end
    num1 = hash.filter_map {|key,value| value if key == best[0] }
    num1[0]
  end

  def worst_offense
    worst = average_goals.min_by {|key,value| value}
    hash = Hash.new
    @teams.map do |row|
      team_id = row[:team_id]
      team_name = row[:teamname]
      hash[team_id] = team_name
    end
    the_worst = hash.filter_map {|key,value| value if key == worst[0] }
    the_worst[0]
  end

  def highest_scoring_visitor
    team_goals = Hash.new(0)
    @game_teams.map do |row|
      if row[:hoa] == 'away'
        team_id = row[:team_id]
        goals = row[:goals].to_f
        team_goals[team_id] += goals
      end
    end
    team_game = @game_teams.filter_map {|row| row[:team_id] if row[:hoa] == 'away'}.tally
    nested_arr = team_game.values.zip(team_goals.values)
    arr = nested_arr.map {|array| array[1] / array[0]}
    away_avg = Hash[team_game.keys.zip(arr)]
    best_away = away_avg.max_by {|key,value| value}
    team_name(best_away[0].to_i)
  end

  def highest_scoring_home_team
    team_goals = Hash.new(0)
    @game_teams.map do |row|
      if row[:hoa] == 'home'
        team_id = row[:team_id]
        goals = row[:goals].to_f
        team_goals[team_id] += goals
      end
    end
    team_game = @game_teams.filter_map {|row| row[:team_id] if row[:hoa] == 'home'}.tally
    nested_arr = team_game.values.zip(team_goals.values)
    arr = nested_arr.map {|array| array[1] / array[0]}
    home_avg = Hash[team_game.keys.zip(arr)]
    best_home = home_avg.max_by {|key,value| value}
    team_name(best_home[0].to_i)
  end

  def lowest_scoring_visitor
    team_goals = Hash.new(0)
    @game_teams.map do |row|
      if row[:hoa] == 'away'
        team_id = row[:team_id]
        goals = row[:goals].to_f
        team_goals[team_id] += goals
      end
    end
    team_game = @game_teams.filter_map {|row| row[:team_id] if row[:hoa] == 'away'}.tally
    nested_arr = team_game.values.zip(team_goals.values)
    arr = nested_arr.map {|array| array[1] / array[0]}
    away_avg = Hash[team_game.keys.zip(arr)]
    best_away = away_avg.min_by {|key,value| value}
    team_name(best_away[0].to_i)
  end

  def lowest_scoring_home_team
    team_goals = Hash.new(0)
    @game_teams.map do |row|
      if row[:hoa] == 'home'
        team_id = row[:team_id]
        goals = row[:goals].to_f
        team_goals[team_id] += goals
      end
    end
    team_game = @game_teams.filter_map {|row| row[:team_id] if row[:hoa] == 'home'}.tally
    nested_arr = team_game.values.zip(team_goals.values)
    arr = nested_arr.map {|array| array[1] / array[0]}
    home_avg = Hash[team_game.keys.zip(arr)]
    best_home = home_avg.min_by {|key,value| value}
    team_name(best_home[0].to_i)
  end

end
