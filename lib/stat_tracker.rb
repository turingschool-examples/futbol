require_relative "./game_teams_stats"
require_relative "./game_stats"
require_relative "./teams_stats"
require_relative "./groupable"
require_relative "./isolatable"
require_relative "./averagable"

class StatTracker
  include Groupable
  include Isolatable
  include Averagable

  attr_reader :game_stats, :teams_stats, :game_teams_stats

  def initialize(game_stats, teams_stats, game_teams_stats)
    @game_stats = game_stats
    @teams_stats = teams_stats
    @game_teams_stats = game_teams_stats
  end

  def self.from_csv(locations)
    game_stats = GameStats.from_csv(locations[:games])
    teams_stats = TeamsStats.from_csv(locations[:teams])
    game_teams_stats = GameTeamsStats.from_csv(locations[:game_teams])
    StatTracker.new(game_stats, teams_stats, game_teams_stats)
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def count_of_teams
    @teams_stats.count_of_teams
  end

  def best_offense
    @teams_stats.team_id_to_name[maximum(@game_teams_stats.best_offense)[0]] #uses a helper method
  end

  def worst_offense
    @teams_stats.team_id_to_name[minimum(@game_teams_stats.worst_offense)[0]] #uses a helper method
  end

  def highest_scoring_visitor
    @teams_stats.team_id_to_name[maximum(@game_stats.visitor_teams_average_score)[0]]
  end

  def highest_scoring_home_team
    @teams_stats.team_id_to_name[maximum(@game_stats.home_teams_average_score)[0]]
  end

  def lowest_scoring_visitor
    @teams_stats.team_id_to_name[minimum(@game_stats.visitor_teams_average_score)[0]]
  end

  def lowest_scoring_home_team
    @teams_stats.team_id_to_name[minimum(@game_stats.home_teams_average_score)[0]]
  end

  def most_goals_scored(team_id)
    @game_teams_stats.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_teams_stats.fewest_goals_scored(team_id)
  end

  def average_win_percentage(team_id)
    ((@game_teams_stats.win_isolator(team_id).count).to_f / (@game_teams_stats.team_isolator(team_id).count)).round(2)
  end

  def team_info(team_id)
    @teams_stats.team_info(team_id)
  end

  def best_season(team_id)
    @game_stats.best_season(team_id)
  end

  def worst_season(team_id)
    @game_stats.worst_season(team_id)
  end

  def most_tackles(season)
    tackles_by_team = all_tackles_this_season(season)
    @teams_stats.team_id_to_name[maximum(tackles_by_team)[0]]
  end

  def fewest_tackles(season)
    tackles_by_team = all_tackles_this_season(season)
    @teams_stats.team_id_to_name[minimum(tackles_by_team)[0]]
  end

  def winningest_coach(season_id)
    game_id_list = @game_stats.games_by_season(season_id)
    coaches = @game_teams_stats.isolate_coach_wins(game_id_list)
    maximum(@game_teams_stats.coach_percentage_won(coaches, game_id_list))[0]
  end

  def worst_coach(season_id)
    game_id_list = @game_stats.games_by_season(season_id)
    coaches = @game_teams_stats.isolate_coach_loss(game_id_list)
    minimum(@game_teams_stats.coach_percentage_loss(coaches, game_id_list))[0]
  end

  def most_accurate_team(season_id)
    max_ratio = season_ratio_by_team(season_id).max_by { |k, v| v }[0]
    @teams_stats.teams.each do |team|
      return team.team_name if team.team_id == max_ratio
    end
  end

  def least_accurate_team(season_id)
    min_ratio = season_ratio_by_team(season_id).min_by { |k, v| v }[0]
    @teams_stats.teams.each do |team|
      return team.team_name if team.team_id == min_ratio
    end
  end

  def season_ratio_by_team(season_id)
    game_id_list = @game_stats.games_by_season(season_id)
    average_goals_to_shots_by_season(season_id, game_id_list)
  end

  def favorite_opponent(team_id)
    game_hash = Hash.new { |h, k| h[k] = { is_our_team: false, other_team_id: nil, winning_team_id: nil } }
    @game_teams_stats.game_teams.each do |game|
      game_id = game.game_id
      winner = nil
      if game.result == "WIN"
        winner = game.team_id
      end
      if game.team_id == team_id
        game_hash[game_id][:is_our_team] = true
      else
        game_hash[game_id][:other_team_id] = game.team_id
      end
      if winner
        game_hash[game_id][:winning_team_id] = winner
      end
    end
    game_hash = game_hash
      .find_all { |game_id, teams_hash| teams_hash[:is_our_team] }
      .to_h
    team_scores = Hash.new { |h, k| h[k] = { wins: 0.0, losses: 0.0, ties: 0.0 } }
    game_hash.each do |game_id, teams_hash|
      other_team_id = teams_hash[:other_team_id]
      if teams_hash[:winning_team_id] == team_id
        team_scores[other_team_id][:losses] += 1
      elsif teams_hash[:winning_team_id] == other_team_id
        team_scores[other_team_id][:wins] += 1
      else
        team_scores[other_team_id][:ties] += 1
      end
    end

    min_win_percent =
      team_scores.min do |team_win_1, team_win_2|
        win_percentage_1 = (team_win_1[1][:wins] / (team_win_1[1][:losses] + team_win_1[1][:ties] + team_win_1[1][:wins])) * 100
        win_percentage_2 = (team_win_2[1][:wins] / (team_win_2[1][:losses] + team_win_2[1][:ties] + team_win_2[1][:wins])) * 100
        win_percentage_1 <=> win_percentage_2
      end
    min_win_team_id = min_win_percent[0]
    @teams_stats.team_id_to_name[min_win_team_id]
  end

  def rival(team_id)
    game_hash = Hash.new { |h, k| h[k] = { is_our_team: false, other_team_id: nil, winning_team_id: nil } }
    @game_teams_stats.game_teams.each do |game|
      game_id = game.game_id
      winner = nil
      if game.result == "WIN"
        winner = game.team_id
      end
      if game.team_id == team_id
        game_hash[game_id][:is_our_team] = true
      else
        game_hash[game_id][:other_team_id] = game.team_id
      end
      if winner
        game_hash[game_id][:winning_team_id] = winner
      end
    end
    game_hash = game_hash
      .find_all { |game_id, teams_hash| teams_hash[:is_our_team] }
      .to_h
    team_scores = Hash.new { |h, k| h[k] = { wins: 0.0, losses: 0.0, ties: 0.0 } }
    game_hash.each do |game_id, teams_hash|
      other_team_id = teams_hash[:other_team_id]
      if teams_hash[:winning_team_id] == team_id
        team_scores[other_team_id][:losses] += 1
      elsif teams_hash[:winning_team_id] == other_team_id
        team_scores[other_team_id][:wins] += 1
      else
        team_scores[other_team_id][:ties] += 1
      end
    end
    max_win_percent =
      team_scores.max do |team_win_1, team_win_2|
        win_percentage_1 = (team_win_1[1][:wins] / (team_win_1[1][:losses] + team_win_1[1][:ties] + team_win_1[1][:wins])) * 100
        win_percentage_2 = (team_win_2[1][:wins] / (team_win_2[1][:losses] + team_win_2[1][:ties] + team_win_2[1][:wins])) * 100
        win_percentage_1 <=> win_percentage_2
      end
    max_win_team_id = max_win_percent[0]
    @teams_stats.team_id_to_name[max_win_team_id]
  end
end
