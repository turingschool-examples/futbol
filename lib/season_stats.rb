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

  def find_num_games_played_won_in_season(season, team_id)
    results_tracker = {:games_played => 0, :games_won => 0}
    games = get_games_of_season(season)
    games.each do |game|
      if game.team_id == team_id.to_i && game.result == "WIN"
        results_tracker[:games_played] += 1
        results_tracker[:games_won] += 1
      elsif game.team_id == team_id.to_i
        results_tracker[:games_played] += 1
      end
    end
    results_tracker
  end
end
