class GameStatics

  def initialize(game_object_array)
    @games = game_object_array
  end

  def percentage_ties
    tie_count = @games.count { |game| game.away_goals.to_i == game.home_goals.to_i }
    percentage = (tie_count.to_f / @games.count.to_f).round(4) * 100
    p percentage
  end

  def count_of_games_by_season
   season_games = @games.each_with_object(Hash.new(0)) {|game, hash| hash[game.season] += 1}
   p season_games
  end
end