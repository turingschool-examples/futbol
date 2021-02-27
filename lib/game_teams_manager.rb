require_relative './game_team'


class GameTeamsManager
  attr_reader :game_teams

  def initialize(data_path)
    @game_teams = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << GameTeam.new(row)
    end
    list_of_data
  end

  # def team_id_highest_average_goals_all
  #   game_teams.each do |game|
  #     require 'pry'; binding.pry
  #   end
  # end

  def total_goals_by_team
    goals_by_team_id = {}
    game_teams.each do |game|
      if goals_by_team_id[game.team_id].nil?
        goals_by_team_id[game.team_id] = game.goals
      else
        goals_by_team_id[game.team_id] += game.goals
      end
    end
    goals_by_team_id
  end
end
