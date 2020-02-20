require_relative 'game_teams'
require_relative 'data_loadable'
require 'pry'

class GameTeamStats
  include DataLoadable
  attr_reader :game_teams

  def initialize(file_path, object)
    @game_teams = csv_data(file_path, object)
    @team_stats = TeamStats.new("./data/teams.csv", Team)
  end

  def lowest_scoring_visitor
    scoring('away','low')
  end

  def lowest_scoring_home_team
    scoring('home','low')
  end

  def highest_scoring_visitor
    scoring('away','win')
  end

  def highest_scoring_home_team
    scoring('home','win')
  end

  def scoring(hoa, wol)
    scoring_hash = {}
    @game_teams.each do |game|
      if game.hoa == hoa
        update_scoring_hash(scoring_hash, game)
      end
    end
    scoring_hash.each_key do |key|
      scoring_hash[key] = scoring_hash[key][0].to_f / scoring_hash[key][1].to_f
    end
    @team_stats.find_name(low_or_high(wol, scoring_hash))
  end

  def update_scoring_hash(scoring_hash, game)
    if scoring_hash[game.team_id] == nil
      scoring_hash[game.team_id] = [0,0]
    end
    scoring_hash[game.team_id][0] += game.goals.to_i
    scoring_hash[game.team_id][1] += 1
    scoring_hash
  end

  def low_or_high(wol, scoring_hash)
   id  = {'id' => [scoring_hash[scoring_hash.first.first], scoring_hash.first.first]}
   scoring_hash.each_key do |key|
     if id['id'][0] > scoring_hash[key] && wol == 'low'
       update_id(id, key, scoring_hash)
     elsif id['id'][0] < scoring_hash[key] && wol == 'win'
       update_id(id, key, scoring_hash)
     end
   end
   id['id'][1]
  end

 def update_id(id, key, scoring_hash)
   id['id'][1] = key.to_i
   id['id'][0] = scoring_hash[key]
   id
 end
end
