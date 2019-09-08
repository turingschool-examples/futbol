module TeamStatistics

  def team_info(team_id)
    found_team = @teams.fetch(team_id.to_i)
    {
      "team_id" => found_team.team_id.to_s,
      "franchise_id" => found_team.franchise_id.to_s,
      "team_name" => found_team.team_name,
      "abbreviation" => found_team.abbreviation,
      "link" => found_team.link
    }
  end

  def best_season(team_id)
    
    games_by_team = @games.select do |game_id, game|
      game.home_team_id == team_id.to_i || game.away_team_id == team_id.to_i
    end
    require "pry"; binding.pry

    games_by_season = games_by_team.group_by do |game|
      game.season
    end

    games_by_season

  end

end
