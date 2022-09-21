require './lib/stat_tracker'

class Game
  attr_reader :game_id,
              :season,
              :away_goals,
              :home_goals,
              :away_team,
              :home_team,
              :away_team_id,
              :home_team_id

  def initialize(info)
    # require "pry"; binding.pry
    @game_id = info[0]
    @season = info[1]
    @away_team_id = info[4]
    @home_team_id = info[5]
    @away_goals = info[6].to_i
    @home_goals = info[7].to_i
    @away_team = Hash.new(0)
    @home_team = Hash.new(0)
  end

  def import_away_team_data(game_teams_data)
    @away_team = {:result => game_teams_data[3],
                  :head_coach => game_teams_data[5],
                  :shots => game_teams_data[7].to_f,
                  :tackles => game_teams_data[8].to_f
                  }
  end

  def import_home_team_data(game_teams_data)
    @home_team = {:result => game_teams_data[3],
                  :head_coach => game_teams_data[5],
                  :shots => game_teams_data[7].to_f,
                  :tackles => game_teams_data[8].to_f
                 }
  end
end



# a team game that inherits id, season

# has opponent, result(for team), and goals scored.



# a season game
