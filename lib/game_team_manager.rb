require 'CSV'
require './lib/game_team'

class GameTeamManager
  attr_reader :game_teams

  def initialize(file_path)
    @file_path = file_path
    @game_teams = {}
    load
  end

  def load
    data = CSV.read(@file_path, headers: true)
    data.each do |row|
      if @game_teams[row["game_id"]].nil?
        @game_teams[row["game_id"]] = [GameTeam.new(row)]
      else
        @game_teams[row["game_id"]] << GameTeam.new(row)
      end
    end
  end
end
