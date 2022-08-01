class DataWarehouse
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games= games
    @teams = teams
    @game_teams = game_teams
  end

  def data_by_season(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                 end
  end

  def id_team_key
    @teams[:team_id].zip(@teams[:teamname]).to_h
  end

  def season_stats(search_team_id)

    all_win_info = @game_teams.select do |game_team|
      game_team[:result] == "WIN" && game_team[:team_id] == search_team_id
    end

    season_won = []
    @games.each do |game|
      all_win_info.each do |per_game|
      if per_game[:game_id] == game[:game_id]
        season_won << game[:season]
        end
      end
    end
    [season_won, @games.count]
  end

end
