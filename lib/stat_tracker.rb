require "csv"
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'game_team_stats'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_teams, :games_array

  def initialize(locations)
    @game_data = CSV.read(locations[:games], headers:true,
       header_converters: :symbol)
    @team_data = CSV.read(locations[:teams], headers:true,
       header_converters: :symbol)
    @game_team_data = CSV.read(locations[:game_teams],
       headers:true, header_converters: :symbol)
    # @games_array = []
    @games = Game.fill_game_array(@game_data)
    @teams = Team.fill_team_array(@team_data)
    @game_teams = GameTeams.fill_game_teams_array(@game_team_data)
    @game_team_stats = GameTeamStats.new(locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

# Game Statistics
  def highest_total_score
    highest_sum = 0
    @games.each do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
      #require 'pry'; binding.pry
      highest_sum = sum if sum > highest_sum
    end
    highest_sum
  end

# League Statistics
  def count_of_teams
    @teams.count
  end

  def best_offense
    team_hash = {}
    @game_teams.each do |game_team|
      if team_hash[game_team.team_id].nil?
        team_hash[game_team.team_id] = [game_team.goals]
      else
        team_hash[game_team.team_id] << game_team.goals
      end
    end
    sum_goals = 0
      team_hash.map do |team, goals|
        goals.each do |goal|
          sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
      end
      team_hash = team_hash.sort_by {|team_id, avg_goals| avg_goals}.reverse.to_h

      highest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals < highest_avg
      end

      if team_hash.keys.length > 1
        team_names = []
        team_hash.keys.each do |team_id|
          team_names << team_name_helper(team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end




      binding.pry
      if highest_avg.length == 1
      end
      return team_hash

  end



  def team_name_helper(team_id)
    @teams.each do |team|
      if team.team_id == team_id
        return team.team_name
      end
    end
  end

  # Season Statistics

  # Team Statistics
  def team_info(team_id)
    @game_team_stats.team_info(team_id)
  end

  def season_games(game_id)
    @game_team_stats.season_games(game_id)
  end

  def best_season(team_id)
    @game_team_stats.best_season(team_id)
  end

  def worst_season(team_id)
    @game_team_stats.worst_season(team_id)
  end 

  def average_win_percentage(team_id)
    @game_team_stats.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_team_stats.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_team_stats.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @game_team_stats.favorite_opponent(team_id)
  end

  def rival(team_id)
    @game_team_stats.rival(team_id)
  end
end
