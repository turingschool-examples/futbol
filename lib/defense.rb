require 'csv'
require_relative 'team'
require_relative 'game_team'
require_relative 'data_objects/incremental_average'

class Defense

  def self.best_defense
    hash = add_goals_to_opposing_team()

    current_min_team_id = ""
    current_min_avg = nil
    hash.map do |team_id, avg|
      if current_min_avg == nil
        current_min_avg = avg.average
        current_min_team_id = team_id
      elsif (avg.average < current_min_avg)
        current_min_team_id = team_id
        current_min_avg = avg.average
      end
    end
    get_team_name_from_id(current_min_team_id)
  end

  def self.worst_defense
    hash = add_goals_to_opposing_team()

    current_max_team_id = ""
    current_max_avg = -1
    hash.map do |team_id, avg|
      if (avg.average > current_max_avg)
        current_max_team_id = team_id
        current_max_avg = avg.average
      end
    end
    get_team_name_from_id(current_max_team_id)
  end

  def self.add_goals_to_opposing_team
    hash = {}
    GameTeam.all_game_teams.map do |game_team|
      hash[game_team.game_id] = [winning_team(game_team.game_id), losing_team(game_team.game_id)]
    end

    new_hash = {}
    hash.map do |key, value|
      winning_team_id = value[0].keys.pop
      winning_team_goals = value[0].values.pop.to_f
      losing_team_id = value[1].keys.pop
      losing_team_goals = value[1].values.pop.to_f
      if new_hash.key?(winning_team_id)
        new_hash[winning_team_id].add_sample(losing_team_goals)
      else
        new_hash[winning_team_id] = IncrementalAverage.new(losing_team_goals)
      end

      if new_hash.key?(losing_team_id)
        new_hash[losing_team_id].add_sample(winning_team_goals)
      else
        new_hash[losing_team_id] = IncrementalAverage.new(winning_team_goals)
      end
    end

    new_hash
  end

  def self.winning_team(game_id)
    win_hash = {}
    y = GameTeam.all_game_teams.find do |game_team|
      game_team.game_id == game_id && (game_team.result == "WIN" || (game_team.result == "TIE" && game_team.hoa == "home"))
    end
    win_hash[y.team_id] = y.goals
    win_hash
  end

  def self.losing_team(game_id)
    lose_hash = {}
    x = GameTeam.all_game_teams.find do |game_team|
      game_team.game_id == game_id && (game_team.result == "LOSS" || (game_team.result == "TIE" && game_team.hoa == "away"))
    end
    lose_hash[x.team_id] = x.goals
    lose_hash
  end

  def self.get_team_name_from_id(team_id)
    Team.all_teams.map do |team|
      if team_id == team.team_id
        return team.team_name
      end
    end
  end
end
