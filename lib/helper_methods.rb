require_relative 'games'
require_relative 'stat_tracker'


module HelperMethods
  def calculate_total_score(game)
    game.away_goals + game.home_goals
  end   

end
