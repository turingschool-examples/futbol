module SeasonUtility

  def all_games_by_season
    @all_games_by_season ||= @games.group_by { |game| game.season } 
  end

end