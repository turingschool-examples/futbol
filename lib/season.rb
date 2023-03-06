class Season

  attr_reader :season_data, :season_id, :team_ids

  def initialize(season_id, games, game_teams)
    @season_id = season_id
    @raw_games = games
    @raw_game_teams = game_teams
    @season_data = create_season_data(@raw_games, @raw_game_teams)
  end
    
  def create_season_data(raw_games, raw_game_teams)
    season_games = raw_games.select{|game| game.season == @season_id}
    season_game_ids = season_games.map{|game| game.game_id}.uniq
    game_team_game_ids = raw_game_teams.map{|game_team| game_team.game_id}.uniq
    matching_game_ids = season_game_ids & game_team_game_ids
    season_game_teams = raw_game_teams.select{|game_team| matching_game_ids.include?(game_team.game_id)}
    team_ids = season_game_teams.map{|game_team| game_team.team_id}.uniq

    season_data = {:games=>season_games, :game_teams=>season_game_teams, :team_ids=>team_ids}
  end
end