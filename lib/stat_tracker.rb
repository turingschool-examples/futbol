require "csv"
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
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
    # binding.pry
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

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |team_id|
          team_names << team_name_helper(team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def worst_offense
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
      team_hash = team_hash.sort_by {|team_id, avg_goals| avg_goals}.to_h

      lowest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals > lowest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |team_id|
          team_names << team_name_helper(team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def lowest_scoring_visitor
    team_hash = {}
    @games.each do |game|
      if team_hash[game.away_team_id].nil?
        team_hash[game.away_team_id] = [game.away_goals]
      else
        team_hash[game.away_team_id] << game.away_goals
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
      team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.to_h

      lowest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals > lowest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
          team_names << team_name_helper(away_team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def highest_scoring_visitor
    team_hash = {}
    @games.each do |game|
      if team_hash[game.away_team_id].nil?
        team_hash[game.away_team_id] = [game.away_goals]
      else
        team_hash[game.away_team_id] << game.away_goals
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
      team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.reverse.to_h

      highest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals < highest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
          team_names << team_name_helper(away_team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def highest_scoring_home_team
    team_hash = {}
    @games.each do |game|
      if team_hash[game.home_team_id].nil?
        team_hash[game.home_team_id] = [game.home_goals]
      else
        team_hash[game.home_team_id] << game.home_goals
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
      team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.reverse.to_h

      highest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals < highest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
          team_names << team_name_helper(away_team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def lowest_scoring_home_team
    team_hash = {}
    @games.each do |game|
      if team_hash[game.home_team_id].nil?
        team_hash[game.home_team_id] = [game.home_goals]
      else
        team_hash[game.home_team_id] << game.home_goals
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
      team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.to_h

      lowest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals > lowest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
          team_names << team_name_helper(away_team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def team_name_helper(team_id)
    @teams.each do |team|
      if team.team_id == team_id
        return team.team_name
      end
    end
  end

  # Season Statistics

  def winningest_coach
    ## Take in an argument that is year/season
    #organize by team_id
    #team_id.length, return total_games
    #look at result
    #wins = +1, loss = 0, tie = 0, return win_total
    #total wins / total games
    #return percentage
    #iterate through year/season to compare percentages
    #return highest percentage and coach
  end


  def organize_seasons # Take in an argument that is year/season
    season_hash = @game_teams.group_by do |game|
      game.game_id[0..3]
    end
    season_hash
  end

  def organize_teams #organize by team_id
    team_hash


  end

  # Team Statistics

  def favorite_opponent
    #one opponents lowest win percentage against another team
    #

end
