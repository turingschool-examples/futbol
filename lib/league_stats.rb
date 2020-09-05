module LeagueStats
  def count_of_teams
    require "pry"; binding.pry
    team_ids = @game_teams.map(&:team_id)
    team_ids.uniq.count
  end
end
