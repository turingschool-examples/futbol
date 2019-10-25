require_relative './game_team'
require 'CSV'

class GameTeamCollection
  attr_reader :game_teams

  def initialize(csv_file_path)
    @game_teams = create_game_teams(csv_file_path)
  end

  def create_game_teams(csv_file_path)
    game_teams = []
    CSV.foreach("#{csv_file_path}", headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row)
      # require "pry"; binding.pry
    end
    game_teams
  end

  def count_of_teams
    team_id_array = @game_teams.map { |gt| gt.team_id }
    team_id_array.uniq.length
  end

  # def home_win_percent
  #   require "pry"; binding.pry
  # end

  # def best_fans
  #   home_game_total = @game_teams.count do |game|
  #     game.HoA == "home"
  #   end
  # end
end
