require './lib/game_teams'

module LeagueStats

  def count_of_teams
    teams = TeamStats.create_list_of_teams(@teams)
    teams.map { |team| team.length}
  end

end
