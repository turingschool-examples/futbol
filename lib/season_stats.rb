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

  def calc_season_win_percentage(season, team_id)
    season_results = find_num_games_played_won_in_season(season, team_id)
    (season_results[:games_won].to_f / season_results[:games_played]).round(2)
  end

  def winningest_coach(season)
    team_ids = []
    games = get_games_of_season(season)

    games.each do |game|
      team_ids << game.team_id if team_ids.any?{|id| id == game.team_id} == false
    end

    percentage_tracker = -1
    id_tracker = nil

    team_ids.each do |id|
      percentage = calc_season_win_percentage(season, id)
      if percentage > percentage_tracker
        percentage_tracker = percentage
        id_tracker = id
      end
    end

    winner = games.find{|x| x.team_id == id_tracker}
    winner.head_coach
  end

end
