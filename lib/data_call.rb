module DataCall
  def team_data
    @stat_tracker.team_manager.teams
  end

  def game_ids_by_team(id)
    game_teams.select { |game_team| game_team.team_id == id }.map(&:game_id)
  end

  def game_team_info(game_id)
    game_teams.select do |game_team|
      game_team.game_id == game_id
    end.reduce({}) do |collector, game|
      collector[game.team_id] = game.game_team_info
      collector
    end
  end
end