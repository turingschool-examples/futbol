class SeasonStats
  attr_reader :teams, :game_stats

  def initialize(teams, game_stats)
    @teams = teams
    @game_stats = game_stats
  end

  def get_games_of_season(season)
    @game_stats.game_stats.find_all do |game|
      game.game_id.to_s[0..3] == season[0..3]
    end
  end

end
