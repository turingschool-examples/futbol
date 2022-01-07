require_relative '../managers/team_manager.rb'
require 'pry'
# TeamStatistics knows about multiple teams
class TeamStatistics
  attr_reader :manager

  def initialize(team_manager)
    @team_manager = team_manager
  end

# return a hash of all team attributes except for stadium
  def team_info(team_id)
    hash = {}
    @team_manager.data.select do |team|
      if team.team_id == team_id
      # require "pry"; binding.pry
        hash[:team_id] = team.team_id
        hash[:franchise_id] = team.franchise_id
        hash[:team_name] = team.team_name
        hash[:abbreviation] = team.abbreviation
        hash[:link] = team.link
      end
    end
    return hash
  end

# returns season with lowest win percentage for a team
  def best_season(team_id)
#  starts with game_team_object.team_id == team_id argument
#  will return game_object.season at the end
  end

# returns season with lowest win percentage for a team
  def worst_season(team_id)
#  starts with game_team_object.team_id == team_id argument
#  will return game_object.season at the end
  end

# returns average win percentage of all games for a team
# what is average win percentage vs win percentage?
  def average_win_percentage(team_id)
#  starts with game_team_object.team_id == team_id argument
  end

# Highest number of goals a team has scored in a single game.
  def most_goals_scored

  end
# Lowest numer of goals a team has scored in a single game.
  def fewest_goals_scored

  end

# Name of opponent that has the lowest win percentage against the given team.
  def favorite_opponent
# returns team.name
  end


  # Name of opponent that has the highest win percentage against the given team.
  def rival

  end

  # Michael's methods --ignore this

  def convert_id_to_team_name(team_id)
    matching_team = @team_manager.data.find{ |team| team.team_id == team_id }
    return matching_team.team_name
  end
end
a = TeamStatistics.new(TeamManager.new('./data/teams.csv'))
