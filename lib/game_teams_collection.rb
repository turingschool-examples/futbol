class GameTeamsCollection

  def initialize()
    @game_teams = {}
  end

  def add(game_team_to_add)
    @game_teams[game_team_to_add.game_id] = {} if !@game_teams.has_key?(game_team_to_add.game_id)
    @game_teams[game_team_to_add.game_id][game_team_to_add.team_id] = game_team_to_add
  end
end
