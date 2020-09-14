class TeamManager
  attr_reader :teams, :tracker

  def initialize(path, tracker)
    @teams = []
    @tracker = tracker
    create_teams(path)
  end

  def create_teams(path)
    teams_data = CSV.read(path, headers:true)

    @teams = teams_data.map do |data|
      Team.new(data, self)
    end
  end

  def initialize_team_stats_hash
    team_stats_hash = {}
    teams.each do |team|
      team_stats_hash[team.team_id] = { total_games: 0, total_goals: 0,
                                           away_games: 0, home_games: 0,
                                           away_goals: 0, home_goals: 0 }
    end
    team_stats_hash
  end
end
