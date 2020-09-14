require './lib/stats'
class GameTeamsStats < Stats
  attr_reader :game_teams_data,
              :tracker

  def initialize(location, tracker)
    @tracker = tracker
    super(game_stats_data, game_teams_stats_data, teams_stats_data)
  end

  def all_home_wins
    @game_teams_stats_data.select do |game_team|
      game_team.hoa == "home" && game_team.result == "WIN"
    end
  end

  def all_visitor_wins
    @game_teams_stats_data.select do |game_team|
      game_team.hoa == "away" && game_team.result == "WIN"
    end
  end

  def count_of_ties
    double_ties = @game_teams_stats_data.find_all do |game_team|
      game_team.result == "TIE"
    end
    double_ties.count / 2
  end

  def group_by_team_id
    @game_teams_stats_data.group_by do |team|
      team.team_id
    end
  end

  def games_from_season(season)
    @game_teams_stats_data.find_all do |game_team|
      game_team.game_id.to_s.split('')[0..3].join.to_i == season.split('')[0..3].join.to_i
    end
  end

  def winningest_coach(season)
   best_coach =  coach_wins(season).max_by {|coach, win| win}
    best_coach[0]
  end

  def worst_coach(season)
   worst_coach =  coach_wins(season).min_by {|coach, win| win}
    worst_coach[0]
  end

  def most_accurate_team(season)
    @tracker.team_stats.most_accurate_team(season)
  end

  def find_most_accurate_team(season)
    most_accurate = goals_to_shots_ratio_per_season(season).sort_by {|team_id, goals| goals}
    most_accurate[-1][0]
  end

  def find_least_accurate_team(season)
    least_accurate = goals_to_shots_ratio_per_season(season).sort_by {|team_id, goals| goals}
    least_accurate[0][0]
  end

  def least_accurate_team(season)
    @tracker.team_stats.least_accurate_team(season)
  end

  def most_tackles(season)
    @tracker.team_stats.most_tackles(season)
  end

  def find_team_with_most_tackles(season)
    team = total_tackles(season).sort_by {|team_id, tackles| tackles}
    team[-1][0]
  end

  def find_team_with_fewest_tackles(season)
    team = total_tackles(season).sort_by {|team_id, tackles| tackles}
    team[0][0]
  end

  def fewest_tackles(season)
    @tracker.team_stats.fewest_tackles(season)
  end

  def all_team_games(team_id)
    @game_teams_stats_data.find_all do |game_team|
      game_team.team_id == team_id.to_i
    end
  end
end
