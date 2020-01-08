require 'csv'
require_relative 'game_team'
require_relative 'team'
require_relative 'game'
require_relative 'data_objects/incremental_average'

class Tackle

  def self.most_tackles(season)
    #Name of the Team with the most tackles in the season
    # hash = get_team_tackles_avg_hash(season)
    team_season(season)
    require "pry"; binding.pry

    current_max_team_id = ""
    current_max_avg = -1
    hash.map do |team_id, avg|
      if(avg.average > current_max_avg)
        current_max_team_id = team_id
        current_max_avg = avg.average
      end
    end
    get_team_name_from_id(current_max_team_id)
  end

  def self.fewest_tackles(season)
    #Name of the Team with the fewest tackles in the season
    hash = get_team_tackles_avg_hash(season)

    current_min_team_id = ""
    current_min_avg = nil
    hash.map do |team_id, avg|
      if current_min_avg == nil
        current_min_avg = avg.average
      elsif (avg.average < current_min_avg)
        current_min_team_id = team_id
        current_min_avg = avg.average
      end
    end
    get_team_name_from_id(current_min_team_id)
  end

  # def self.add_tackles_to_team(team_id, sample)
  #   if hash.key?(team_id)
  #     hash[team_id].add_sample(sample)
  #   else
  #     hash[team_id] = IncrementalAverage.new(sample)
  #   end
  # end
  def self.team_season(season)
    hash = {}
    require "pry"; binding.pry
    Game.all_games.map do |game|
      if hash.key?(game.season)
        hash[game.season] << game.game_id
      else
        hash[game.season] = game.game_id
      end
    end 
  end

  def self.get_team_tackles_avg_hash(season)
    hash = {}
    tackles = GameTeam.all_game_teams.map do |game_team|
      hash[season] = [game_team.team_id, game_team.tackles.to_f]
    end
    # require "pry"; binding.pry
    # new_hash = {}
    # if hash.key?(tackles.team_id)
    #   new_hash[tackles.team_id].add_sample(tackles.tackles.to_f)
    # else
    #   new_hash[tackles.team_id] = IncrementalAverage.new(tackles.tackles.to_f)
    # end
  end

  def self.get_team_name_from_id(team_id)
    Team.all_teams.map do |team|
      if team_id == team.team_id
        return team.team_name
      end
    end
  end
end
