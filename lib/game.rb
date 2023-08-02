require_relative 'helper_class'

class Game
  attr_reader :game_id,
              :season,
              :away_team_id,
              :away_team_goals,
              :away_team_name,
              :home_team_id,
              :home_team_goals,
              :home_team_name

  def initialize(game_file, team_file)
    @game_id = game_file[:game_id]
    @season = game_file[:season]
    @away_team_id = game_file[:away_team_id]
    @away_team_name = find_away_team_names(team_file)
    @away_team_goals = game_file[:away_team_goals]
    @home_team_id = game_file[:home_team_id]
    @home_team_goals = game_file[:home_team_goals]
    @home_team_name = find_home_team_names(team_file)
  end

  private

  def find_away_team_names(team_file)
    name = nil
    team_file.each do |team| if team[:team_id] == @away_team_id
      name = team[:teamname]
      end
    end
    name
  end

  def find_home_team_names(team_file)
    name = nil
    team_file.each do |team| if team[:team_id] == @home_team_id
      name = team[:teamname]
      end
    end
    name
  end
end