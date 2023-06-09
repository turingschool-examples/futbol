require_relative './game'
require_relative './team'
require_relative './game_team'
require 'csv'

class RawStats
  attr_reader :games, :teams, :game_teams
  
  def initialize(data)
    @games = load_data(data[:games], Game)
    @teams = load_data(data[:teams], Team)
    @game_teams = load_data(data[:game_teams], GameTeam)
  end
  
  def load_data(file, class_type)
    CSV.read(file, headers: true, header_converters: :symbol).map { |row| class_type.new(row) }
  end
end