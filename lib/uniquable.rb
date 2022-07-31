module Uniquable
  def self.unique_seasons_hash(data)
    game_by_season = data[:games]
    total_season = (game_by_season.uniq { |season| season[:season] }).map { |season| season[:season] }
    total_count = Hash.new
    total_season.each { |season| total_count.store(season, []) }
    return game_by_season, total_count
  end
end