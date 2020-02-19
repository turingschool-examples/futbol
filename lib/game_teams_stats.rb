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
    visitor_hash = {}
    @game_teams.each do |game|
      if game.hoa == 'away'
        if visitor_hash[game.team_id] == nil
          visitor_hash[game.team_id] = [0,0]
        end
        visitor_hash[game.team_id][0] += game.goals.to_i
        visitor_hash[game.team_id][1] += 1
      end
    end
    visitor_hash
    visitor_hash.each_key do |key|
      visitor_hash[key] = visitor_hash[key][0].to_f / visitor_hash[key][1].to_f
    end
    lowest_id  = {'id' => [-1, -1]}
    visitor_hash.each_key do |key|
      if lowest_id['id'][0] == -1
        lowest_id['id'][1] = key.to_i
        lowest_id['id'][0] = visitor_hash[key]
      elsif lowest_id['id'][0] > visitor_hash[key]
        lowest_id['id'][0] = visitor_hash[key]
        lowest_id['id'][1] = key.to_i
      end
    end
    binding.pry
    lowest_id
  end
end
