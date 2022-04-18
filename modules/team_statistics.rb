require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/game_teams'

module TeamStatistics
  def team_info(team_id)
    the_team = @teams.find { |team| team.team_id == team_id }
    { 'team_id' => the_team.team_id,
      'franchise_id' => the_team.franchise_id,
      'team_name' => the_team.team_name,
      'abbreviation' => the_team.abbreviation,
      'link' => the_team.link }
  end

  def best_season(team_id)
    season = count_season_wins(team_id).max_by { |_season, wins| wins }[0]
    season + (season.to_i + 1).to_s
  end

  def worst_season(team_id)
    season = count_season_wins(team_id).min_by { |_season, wins| wins }[0]
    season + (season.to_i + 1).to_s
  end

  def average_win_percentage(team_id)
    seasons = count_season_wins(team_id)
    total_games_per_season = @games.count do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end / seasons.length
    percentage = seasons.map { |_season, wins| wins.to_f / total_games_per_season }.sum / seasons.length
    percentage.round(2)
  end

  def count_season_wins(team_id)
    seasons = Hash.new(0)
    @game_teams.each do |game|
      seasons[game.game_id[0..3]] += 1 if game.team_id == team_id && game.result == 'WIN'
    end
    seasons
  end

  def most_goals_scored(team_id)
    teams_games = @game_teams.find_all { |game| game.team_id == team_id }
    teams_games.max_by(&:goals).goals
  end

  def fewest_goals_scored(team_id)
    teams_games = @game_teams.find_all { |game| game.team_id == team_id }
    teams_games.min_by(&:goals).goals
  end

  def favorite_opponent(team_id)
    team_id_to_name(win_ratio_hasher(team_id).last[0])
  end

  def rival(team_id)
    team_id_to_name(win_ratio_hasher(team_id).first[0])
  end

  def opponent_hasher(team_id, outcome)
    opponents = Hash.new(0)
    game_ids = @game_teams.find_all do |game|
                 game.team_id == team_id && game.result == outcome
               end.map { |game| [game.game_id] }.flatten
    games = game_ids.map { |game_id| @games.find { |game| game.game_id == game_id } }
    games.each do |game|
      game.home_team_id == team_id ? (opponents[game.away_team_id] += 1) : (opponents[game.home_team_id] += 1)
    end
    opponents
  end

  def win_ratio_hasher(team_id)
    new = {}
    wins = opponent_hasher(team_id, 'WIN')
    losses = opponent_hasher(team_id, 'LOSS')
    wins.each do |team, wins|
      new[team] = wins / (wins.to_f + losses[team])
    end
    new.sort_by { |_team, percentage| percentage }
  end

  def team_id_to_name(id)
    @teams.find { |team| team.team_id == id }.team_name
  end
end
