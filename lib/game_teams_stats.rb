require_relative 'game_teams'
require_relative 'data_loadable'
require 'pry'

class GameTeamStats
  include DataLoadable
  attr_reader :game_teams

  def initialize(file_path, object)
    @game_teams = csv_data(file_path, object)
  end

  def lowest_scoring_visitor
    vistor_hash = Hash.new([0,0])
    @game_teams.each do |game|
      if game.hoa == 'away'
        vistor_hash[game.team_id][0] += game.goals
        vistor_hash[game.team_id][0] += 1
      end
    end

    vistor_hash
  end

end
