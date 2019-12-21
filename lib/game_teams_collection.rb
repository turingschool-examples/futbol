require 'csv'
require_relative 'game_team'
require_relative 'csvloadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams

  def initialize(game_teams_path)
    @game_teams = create_game_teams(game_teams_path)
  end

  def create_game_teams(game_teams_path)
    create_instances(game_teams_path, GameTeam)
  end

  def set_key_value_for_away_hash(acc, gameteam)
    if gameteam.hoa == "away"
      if acc[gameteam.team_id] == nil
        acc[gameteam.team_id] = []
        acc[gameteam.team_id] << gameteam.goals
      else
        acc[gameteam.team_id] << gameteam.goals
      end
    end
  end

  def hash_away_id_and_goals
    game_teams.reduce({}) do |acc, gameteam|
      set_key_value_for_away_hash(acc, gameteam)
      acc
    end
  end



  def highest_scoring_visitor_id

    id_t_avg = hash_away_id_and_goals.reduce({}) do |acc, kv|
      id = kv[0]
      avg = (kv[1].sum / kv[1].length).to_f

      acc[id] = avg
      acc
    end

    highest_avg = id_t_avg.max_by {|k, v| v}

    id_highest_avg = highest_avg[0]
  end


end

# highest_scoring_visitor	Name of the team with the highest average score per
# game across all seasons when they are away.	String

# id_t_g = game_teams.reduce({}) do |acc, gameteam|
#   if gameteam.hoa == "away"
#     if acc[gameteam.team_id] == nil
#       acc[gameteam.team_id] = []
#       acc[gameteam.team_id] << gameteam.goals
#     else
#       acc[gameteam.team_id] << gameteam.goals
#     end
#   end
#   acc
# end
#
# id_t_avg = id_t_g.reduce({}) do |acc, kv|
#   id = kv[0]
#   avg = (kv[1].sum / kv[1].length).to_f
#
#   acc[id] = avg
#   acc
# end
#
# highest_avg = id_t_avg.max_by {|k, v| v}
#
# id_highest_avg = highest_avg[0]
