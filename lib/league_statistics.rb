require_relative "./stat_tracker"
require_relative "./stat_helper"

class LeagueStatistics < StatHelper

  def initialize(files)
    super
  end

  def count_of_teams
    @teams.length
  end

  # def offense_avg
  #   total_goals = {}
  #   game_count = 0
  #   @game_teams.each do |team|
  #     game_count =
  #     total_goals[team.team_id] = ((team.goals.sum) / game_count)
  #   require 'pry'; binding.pry
  #   end
# ^this method is still in progress, not working yet


  # end

# Pseudocode: access the game_teams.csv file
# Pull the team_id and goals variables for each game
# Add the total number of goals for each team
# Divide the total goals by number of games for each team

  # def best_offense
  #   offense_avg
    
  # end
# ^this method is still in progress, not working yet

# Pseudocode: access the game_teams.csv file
# Pull the team_id and goals variables for each game
# Add the total number of goals for each team
# Divide the total goals by number of games for each team
# ^^ in the offense_avg helper method
# Identify the team_id of the team with the highest average
# Match the team_id to the teamName (in the teams.csv file)
# Return teamName (in a string)


  # def worst_offense
    # offense_avg

  # end

# Pseudocode: access the game_teams.csv file
# Pull the team_id and goals variables for each game
# Add the total number of goals for each team
# Divide the total goals by number of games for each team
# ^^ in the offense_avg helper method
# Identify the team_id of the team with the lowest average
# Match the team_id to the teamName (in the teams.csv file)
# Return teamName (in a string)

  def highest_scoring_visitor
    visitors = @games.group_by(&:away_team_id)
    avg_score = Hash.new(0)

    visitors.map do |team, games|
      total_score = games.map do |game|
        game.away_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end

    highest_avg_score = avg_score.max_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == highest_avg_score.first}.team_name
  end

  def highest_scoring_home_team
    homers = @games.group_by(&:home_team_id)
    avg_score = Hash.new(0)

    homers.map do |team, games|
      total_score = games.map do |game|
        game.home_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end

    highest_avg_score = avg_score.max_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == highest_avg_score.first}.team_name
  end

  def lowest_scoring_visitor
    visitors = @games.group_by(&:away_team_id)
    avg_score = Hash.new(0)

    visitors.map do |team, games|
      total_score = games.map do |game|
        game.away_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end

    lowest_avg_score = avg_score.min_by {|id, avg| avg}
    @teams.find {|team| team.team_id == lowest_avg_score.first}.team_name
  end

  def lowest_scoring_home_team
    homers = @games.group_by(&:home_team_id)
    avg_score = Hash.new(0)

    homers.map do |team, games|
      total_score = games.map do |game|
        game.home_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end

    lowest_avg_score = avg_score.min_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == lowest_avg_score.first}.team_name
  end
end
