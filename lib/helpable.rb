module Helpable #each module should have a defined purpose/goal; think "addressable"; there could be value in using a certain thing on another class


  #I'm not sure we use this anywhere?
  # def get_team_games_by_single_season(team_id, season) #games helper, returns array of all of a team's games for one season
  #   games_by_season = []
  #   @games.each do |game|
  #     if (game.home_team_id == team_id || game.away_team_id == team_id) && game.season == season
  #       games_by_season << game
  #     end
  #   end
  #   games_by_season
  # end

  def minimum(average) #helper method
    average.min { |avg_1, avg_2| avg_1[1] <=> avg_2[1] }
  end

  def maximum(average) #helper method
    average.max { |avg_1, avg_2| avg_1[1] <=> avg_2[1] }
  end

end