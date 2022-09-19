require 'csv'
require 'pry'

class StatHelper
  # Was line 307 in stat_tracker
  def games_by_season
    @games_by_season_hash = Hash.new([])
    @games.each do |game|
      @games_by_season_hash[game[:season]] += [game[:game_id]]
    end
    @games_by_season_hash
  end
end