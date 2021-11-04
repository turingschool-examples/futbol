class SeasonStats
  attr_reader :game_data,
              :team_data,
              :games_teams

  def initialize(current_stat_tracker)
    @game_data = current_stat_tracker.games
    @team_data = current_stat_tracker.teams
    @games_teams = current_stat_tracker.games_teams
  end
end
