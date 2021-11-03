class LeagueStats
  attr_reader :game_data,
              :team_data,
              :game_teams

  def initialize(current_stat_tracker)
    @game_data = current_stat_tracker.games
    @team_data = current_stat_tracker.teams
    @game_teams = current_stat_tracker.game_teams
  end

  def count_of_teams
    @team_data.count
  end
end
