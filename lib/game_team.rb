require_relative 'helper_class'

class GameTeam
  attr_reader :game_id,
              :team_id,
              :home,
              :result,
              :coach,
              :teamname

  def initialize(game_team_file, team_file)
    @game_id = game_team_file[:game_id]
    @team_id = game_team_file[:team_id]
    @home = game_team_file[:hoa] == "home"
    @result = game_team_file[:results]
    @coach = game_team_file[:coach]
    @goals = game_team_file[:goals]
    @teamname = find_teamname(team_file)
  end

private

  def find_teamname(team_file)
    name = nil
    team_file.each do |team| if team[:team_id] == @team_id
      name = team[:teamname]
      end
    end
    name
  end

end