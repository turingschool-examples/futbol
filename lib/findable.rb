module Findable
  # def games_in_season_by_header(identifier, header)
  #   season_game_teams_rows(identifier).group_by {|game| game[header]}
  # end

  def find_in_sheet(identifier, header, sheet)
    # creates array of all season games
    collection = sheet.select do |row|
      row[header] == identifier
    end
  end

  # def access_sheet_data_that_matches_other_sheet(season)
  #   game_ids = season_games_rows(season).map do |game|
  #     game[:game_id]
  #   end
  #   games = @game_teams.select do |game|
  #     game_ids.include?(game[:game_id])
  #   end
  # end
  #

  # def season_games_rows(season)
  #   # creates array of all season games
  #   season_games = @games.select do |game|
  #     game[:season] == season
  #   end
  # end
  #
  # def season_game_teams_rows(season)
  #   game_ids = season_games_rows(season).map do |game|
  #     game[:game_id]
  #   end
  #   games = @game_teams.select do |game|
  #     game_ids.include?(game[:game_id])
  #   end
  # end

  # def games_in_season(season)
  #   #look at games csv -- grab rows that fit a certain criteria
  #   #then go to game_teams and grab rows that align using same game_id
  #   season_games = @games.select do |game|
  #     game[:season] == season
  #   end
  #   game_ids = season_games.map do |game|
  #     game[:game_id]
  #   end
  #   games = @game_teams.select do |game|
  #     game_ids.include?(game[:game_id])
  #   end
  # end
end
