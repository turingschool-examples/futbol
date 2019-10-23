require_relative 'games'
require_relative 'stat_tracker'


module HelperMethods
  def calculate_total_score(game)
    game.away_goals + game.home_goals
  end

  def generate_seasons_hash(games)
    avg_by_season = Hash.new
    seasons = games.map {|game| game.season}.uniq
    seasons.each {|season| avg_by_season[season] = 0}
  end   

end
