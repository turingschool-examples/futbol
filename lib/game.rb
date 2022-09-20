require './lib/stat_tracker'

class Game #< StatTracker
  attr_reader :game_id,
              :season,
              :away_goals,
              :home_goals,
              :away_team,
              :home_team

  def initialize(info)
    @game_id = info[0]
    @season = info[1]
    @away_goals = info[6].to_i
    @home_goals = info[7].to_i
    @away_team = Hash.new(0)
    @home_team = Hash.new(0)
  end

  def import_away_team_data(game_teams_data)
    @away_team = {:team_id => game_teams_data[1],
                  :result => game_teams_data[3],
                  :head_coach => game_teams_data[5],
                  # # goals: game_teams_data_0[6],
                  :shots => game_teams_data[7].to_f,
                  :tackles => game_teams_data[8].to_f
                  }
  end

  def import_home_team_data(game_teams_data)
    @home_team = {:team_id => game_teams_data[1],
                  :result => game_teams_data[3],
                  :head_coach => game_teams_data[5],
                  # goals: game_teams_data_1[6],
                  :shots => game_teams_data[7].to_f,
                  :tackles => game_teams_data[8].to_f
                }
  end

end
