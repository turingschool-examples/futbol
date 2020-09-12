require 'csv'

class GameTeamManager
  attr_reader :game_teams,
              :tracker
  def initialize(path, tracker)
    @game_teams = []
    create_underscore_game_teams(path)
    @tracker = tracker
  end

  def create_underscore_game_teams(path)
    game_teams_data = CSV.read(path, headers: true)
    @game_teams = game_teams_data.map do |data|
      GameTeam.new(data, self)
    end
  end

  def average_win_percentage(team_id)
    team_game_count = Hash.new(0)
    team_wins = Hash.new(0)
    @game_teams.each do |game|
      if game.team_id == team_id
        team_game_count[game.team_id] += 1
        if game.result == "WIN"
          team_wins[game.team_id] += 1
        end
      end
    end
    (team_wins[team_id].to_f / team_game_count[team_id]).round(2)
  end
end
