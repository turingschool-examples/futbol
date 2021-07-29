class TeamStatistics
  attr_reader :games, :teams, :game_teams

  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def team_info(team_id)
    team_info = {}
    @teams.each do |team|
      team.team_id
      team_info[:team_id] = team.team_id
      team_info[:franchise_id] = team.franchise_id
      team_info[:team_name] = team.team_name
      team_info[:abbreviation] = team.abbreviation
      team_info[:link] = team.link
    end
  end



end
