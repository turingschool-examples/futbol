require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require 'CSV'

class StatTracker
attr_reader :games, :teams, :game_teams, :seasons, :league

def self.from_csv(locations)
  StatTracker.new(locations)
end

def initialize(data)
  @games = game_init(data)
  @teams = teams_init(data)
  @game_teams = game_teams_init(data)
  # @seasons = Season.new(@games)
  # @league = League.new(@teams, @games)
  # @game_stats = GameStats.new(@teams)
end

def game_init(data)
  CSV.read(data[:games], headers: true, header_converters: :symbol).map {|row| Game.new(row) }
end

def teams_init(data)
  CSV.read(data[:teams], headers: true, header_converters: :symbol).map {|row| Team.new(row) }
end

def game_teams_init(data)
  CSV.read(data[:game_teams], headers: true, header_converters: :symbol).map {|row| GameTeam.new(row) }
end

# GAME STATS

  def highest_total_score
    output = @games.max do |game1, game2|
      (game1.away_goals + game1.home_goals) <=> (game2.away_goals + game2.home_goals)
    end
    return output.away_goals + output.home_goals
  end

  def lowest_total_score
    output = @games.min do |game1, game2|
      (game1.away_goals + game1.home_goals) <=> (game2.away_goals + game2.home_goals)
    end
    return output.away_goals + output.home_goals
  end


  #league_stats
# Name of the team with the highest average number of 
# goals scored per game across all seasons.
  def best_offense
    game_team_goals = {}
    @game_teams.each do |game_team|
      game_team_goals[game_team.team_id.to_sym] = []
      end
    @game_teams.each do |game_team|
      goal_array = game_team_goals[game_team.team_id.to_sym]
      goal_array << game_team.goals.to_i
    end
    game_team_goals.map do |team, goal_array|
      game_team_goals[team] = (goal_array.sum.to_f / goal_array.length.to_f)
    end

    best_avg = game_team_goals.max_by{ |team, goals| goals }

    team = @teams.find do |team|
    best_avg[0].to_s == team.team_id
    end
    team.team_name
  end
    # make array of goals from each team's games into separate values of team total goals (goals on gameteam)
    # add up all goals from each of those arrays -- array#sum
    # divide each of those values by the count -- array#count
    # find largest number

  def worst_offense
    game_team_goals = {}
    @game_teams.each do |game_team|
      game_team_goals[game_team.team_id.to_sym] = []
      end
    @game_teams.each do |game_team|
      goal_array = game_team_goals[game_team.team_id.to_sym]
      goal_array << game_team.goals.to_i
    end
    game_team_goals.map do |team, goal_array|
      game_team_goals[team] = (goal_array.sum.to_f / goal_array.length.to_f)
    end

    worst_avg = game_team_goals.min_by{ |team, goals| goals }

    team = @teams.find do |team|
    worst_avg[0].to_s == team.team_id
    end
    team.team_name
  end

  #season_stats
  
  #Name of the Team with the most tackles in the season
  # def most_tackles(season_id)
    # find all GameTeam objects with the season id argument
    # iterate through these GameTeam objects
    # return a hash with the team id pointing to an array of all the tackle stats from each game
    # 


  # end
end
