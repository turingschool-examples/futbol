require 'csv'
require_relative 'team'
require_relative 'game_team'
require_relative 'data_objects/incremental_average'

class Defense

  def self.best_defense
# FC Cincinnati 26
    hash = add_goals_to_opposing_team()
# require "pry"; binding.pry
    current_min_team_id = ""
    current_min_avg = -1
    hash.map do |team_id, avg|
      if current_min_avg == -1
        current_min_avg = avg.average
      else (avg.average < current_min_avg)
        current_min_team_id = team_id
        current_min_avg = avg.average
      end
    end
    get_team_name_from_id(current_min_team_id)
  end

  def self.worst_defense
    # Columbus Crew SC 53
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
      # puts "Hi I'm a string " + winning_team("2012030121").to_s
    end
    new_hash = {}
    hash.map do |key, value|
      # require "pry"; binding.pry
      winning_team_id = value[0].keys.pop
      winning_team_goals = value[1].values.pop.to_f
      losing_team_id = value[1].keys.pop
      losing_team_goals = value[0].values.pop.to_f
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
        # require "pry"; binding.pry
      end
      new_hash
  end

  def self.winning_team(game_id)
    win_hash = {}
    y = GameTeam.all_game_teams.find do |game_team|
      # require "pry"; binding.pry
      game_team.game_id == game_id && (game_team.result == "WIN" || (game_team.result == "TIE" && game_team.hoa == "home"))
      # if (game_team.result == "WIN")  && (game_team.game_id == game_id)
      #     win_hash[game_team.team_id] = game_team.goals
      # else (game_team.result == "TIE") && (game_team.hoa == "home") && (game_team.game_id == game_id)
      #     win_hash[game_team.team_id] = game_team.goals
      # end
    end
    win_hash[y.team_id] = y.goals
    win_hash
  end

  def self.losing_team(game_id)
    lose_hash = {}
    x = GameTeam.all_game_teams.find do |game_team|
      game_team.game_id == game_id && (game_team.result == "LOSS" || (game_team.result == "TIE" && game_team.hoa == "away"))
      # if (game_team.result == "LOSS") && (game_team.game_id == game_id)
      #     lose_hash[game_team.team_id] = game_team.goals
      # else (game_team.result == "TIE") && (game_team.hoa == "away") && (game_team.game_id == game_id)
      #     lose_hash[game_team.team_id] = game_team.goals
      # end
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
