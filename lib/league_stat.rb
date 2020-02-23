class LeagueStat

  attr_reader :stats_by_team

  def initialize(teams_list, games_list)
    @stats_by_team = Hash.new do |hash, key|
      hash[key] = Hash.new { |hash, key| hash[key] = 0 }
    end
    create_teams(teams_list)
    create_league_stats(games_list)
  end

  def create_teams(teams)
    teams.each do |team|
      stats_by_team[team.team_id] = {team_name: team.team_name}
    end
  end

  def create_league_stats(games)
    # games.each do |game|
    #   require 'pry'; binding.pry
    # end
  end

  def count_of_teams
    stats_by_team.keys.size
  end

end
