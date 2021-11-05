require 'CSV'
require 'pry'

require_relative './game_teams'

class GameTeamsManager
  attr_reader :game_teams_objects, :game_teams_path

  def initialize(game_teams_path)
    @game_teams_path = './data/game_teams.csv'
    @game_teams_objects = (
      objects = []
      CSV.foreach(game_teams_path, headers: true, header_converters: :symbol) do |row|
        objects << GameTeams.new(row)
      end
      objects)
  end

  def best_offense
      team_ids = []
      team_goals = []
      @game_teams_objects.each do |game|
          team_ids << game.team_id
          team_goals << game.goals

      end
      ids_goals_array = team_ids.zip(team_goals)
      ids_goals_array
  end



end
