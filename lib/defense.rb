require 'csv'
require_relative 'team'
require_relative 'game_team'
require_relative 'data_objects/incremental_average'

class Defense

  def self.best_defense
    hash = get_team_goal_avg_hash()

    current_min_team_id = ""
    current_min_avg = -1
    hash.map do |team_id, avg|
      if current_min_avg == -1
        current_min_avg = avg.average
      else(avg.average < current_min_avg)
        current_min_team_id = team_id
        current_min_avg = avg.average
      end
    end
    get_team_name_from_id(current_min_team_id)
  end

  def self.get_team_goal_avg_hash
    hash = {}
    winning_team = GameTeam.all_game_teams.map do |game_team|
      add_goals_to_oposing_team(game_team.game_id, game_team.team_id, game_team.goals.to_f, hash)
    end
    hash
  end

  def self.add_goals_to_oposing_team(game_id, team_id, goals, hash)
    GameTeam.all_game_teams.map do |game_team|
      if game_team.game_id == game_id
        if hash.key?(team_id)
          hash[team_id].add_sample(goals)
        else
          hash[team_id] = IncrementalAverage.new(goals)
        end
      end
    end
  end

  def self.get_team_name_from_id(team_id)
    Team.all_teams.map do |team|
      if team_id == team.team_id
        return team.team_name
      end
    end
  end
end
