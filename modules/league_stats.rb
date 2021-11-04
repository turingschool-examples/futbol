require './creator'
module LeagueStats

  def count_of_teams
    creator.teams_hash.count
  end
end