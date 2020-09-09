
class LeagueStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def count_of_teams
    stat_tracker[:teams]["team_id"].count
  end

  def team_id_team_name_data_set
    stat_tracker[:teams]["team_id"].zip(stat_tracker[:teams]["teamName"])
  end

  def find_best_offense
    offense_list.max_by do |team_id, avg_goals_per_game|
      avg_goals_per_game
    end.to_a
  end

  def best_offense
    name = team_id_team_name_data_set.find do |set|
      if set[0] == find_best_offense[0]
        team_id_team_name_data_set
      end
    end
    name[1]
  end

  def offense_list
    offense_list = {}
    games_per_team.each do |team_id, number_games|
      offense_list[team_id] = total_points_by_team[team_id].to_f / number_games
    end
    offense_list
  end

  def games_per_team #team_id => total_games_in_a_season
    count_teams = {}
    stat_tracker[:teams]["team_id"].each do |team_number|
      count_teams[team_number] = count_of_teams do |team_id|
        team_id == team_number
      end
    end
    count_teams
  end

  def team_goals_data_set
    stat_tracker[:game_teams]["team_id"].zip(stat_tracker[:game_teams]["goals"])
  end

  def total_points_by_team
    grouping = {}
    team_goals_data_set.each do |array|
      if grouping[array[0]].nil?
        grouping[array[0]] = array[1].to_i
      else
        grouping[array[0]] += array[1].to_i
      end
      # require 'pry';binding.pry
    end
    grouping
  end
# def total_goals_per_team
#   team_goals = {}
#   stat_tracker[:game_teams]["team_id"].each do |team_id|
#     team_goals[team_id] = stat_tracker[:game_teams]["goals"].each do |goal|
#       if team_goals[team_id]
#         # require 'pry';binding.pry
#         team_goals[team_id] += goal.to_i
#       else
#         team_goals[team_id] = goal.to_i
#       end
#     end
#   end
#   team_goals
# end
end
