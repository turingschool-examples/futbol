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


end
