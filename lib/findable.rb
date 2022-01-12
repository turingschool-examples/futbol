module Findable
  def games_in_season_by_header(identifier, header)
    games_in_season(identifier).group_by {|game| game[header]}
  end

  def games_in_season(season)
    season_games = @games.select do |game|
      game[:season] == season
    end
    game_ids = season_games.map do |game|
      game[:game_id]
    end
    games = @game_teams.select do |game|
      game_ids.include?(game[:game_id])
    end

  end
end
