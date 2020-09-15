module DataCall
  def team_data
    @stat_tracker.team_manager.teams
  end

  def game_ids_by_team(id)
    game_teams.select { |game_team| game_team.team_id == id }.map(&:game_id)
  end

  def find_game_teams(game_id)
    game_teams.select do |game_team|
      game_team.game_id == game_id
    end
  end

  def game_team_info(game_id)
    find_game_teams(game_id).reduce({}) do |collector, game|
      collector[game.team_id] = game.game_team_info
      collector
    end
  end

  def group_by_season
    @games.group_by { |game| game.season }.uniq
  end

  def game_info(game_id)
    games.find {|game| game.game_id == game_id }.game_info
  end
end