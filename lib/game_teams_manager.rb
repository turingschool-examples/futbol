require_relative './game_team'

class GameTeamsManager
  attr_reader :game_teams, :tracker
  def initialize(game_teams_path, tracker)
    @game_teams = []
    @tracker = tracker
    create_games(game_teams_path)
  end

  def create_games(game_teams_path)
    game_teams_data = CSV.parse(File.read(game_teams_path), headers: true)
    @game_teams = game_teams_data.map do |data|
      GameTeam.new(data, self)
    end
  end

  def average_number_of_goals_scored_by_team(team_id)
    games_played = @game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end
    total_goals = games_played.sum do |game|
      game.goals
    end
    total_goals.to_f/games_played.count
  end

end
