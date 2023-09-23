require "csv"
require "stats"

class StatTracker < Stats
  def self.from_csv(locations)
    games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    new(games_data, teams_data, game_teams_data)
  end

  def initialize(games_data, teams_data, game_teams_data)
    super(games_data, teams_data, game_teams_data)
  end

  ###=== GAME QUERIES ===###

  def highest_total_score
    total_scores.max
  end

  def lowest_total_score
    total_scores.min
  end

  def percentage_home_wins
    percentage_results[:home_wins]
  end

  def percentage_visitor_wins
    percentage_results[:away_wins]
  end

  def percentage_ties
    percentage_results[:ties]
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)

    @games_data.each do |game|
      season = game[:season]
      games_by_season[season] += 1
    end

    games_by_season
  end

  def average_goals_per_game
    average_goals_per(:game)[:total]
  end

  def average_goals_by_season
    average_goals_per(:season)
  end

  ###=== GAME QUERIES ===###

  ###=== LEAGUE QUERIES ===###

  def count_of_teams
    @teams_data.size
  end

  def best_offense
    team_id = team_avg_goals.max_by { |k, v| v }[0]  # max => [team_id, value] from hash

    team_name_from_id(team_id)
  end

  def worst_offense
    team_id = team_avg_goals.min_by { |k, v| v }[0]

    team_name_from_id(team_id)
  end

  def highest_scoring_visitor
    team_id = team_avg_goals(:hoa, "away").max_by { |k, v| v }[0]

    team_name_from_id(team_id)
  end

  def highest_scoring_home_team
    team_id = team_avg_goals(:hoa, "home").max_by { |k, v| v }[0]

    team_name_from_id(team_id)
  end

  def lowest_scoring_visitor
    team_id = team_avg_goals(:hoa, "away").min_by { |k, v| v }[0]

    team_name_from_id(team_id)
  end

  def lowest_scoring_home_team
    team_id = team_avg_goals(:hoa, "home").min_by { |k, v| v }[0]

    team_name_from_id(team_id)
  end

  ###=== LEAGUE QUERIES ===###

  ###=== SEASON QUERIES ===###

  # @season: string of season year start finish: YYYYYYYY
  # @return: name of coach with highest winning pct.
  def winningest_coach(season)
    coach_results = coach_season_win_pct(season)

    coach_results.max_by { |k, v| v }[0]
  end

  def worst_coach(season)
    coach_results = coach_season_win_pct(season)

    coach_results.min_by { |k, v| v }[0]
  end

  def most_accurate_team(season)
    most_accurate_team = team_accuracies(season).max_by { |_, ratio| ratio }
# require 'pry'; binding.pry

    team_name_from_id(most_accurate_team[0])
  end

  def least_accurate_team(season)
    least_accurate_team = team_accuracies(season).min_by { |_, ratio| ratio }

    team_name_from_id(least_accurate_team[0])
  end

  def most_tackles(season)
    max_team_tackles = season_team_tackles(season).max_by { |_, tackles| tackles }

    team_name_from_id(max_team_tackles[0])
  end

  def fewest_tackles(season)
    low_team_tackles = season_team_tackles(season).min_by { |_, tackles| tackles }

    team_name_from_id(low_team_tackles[0])
  end
  ###=== SEASON QUERIES ===###

  ###=== TEAM QUERIES ===###

  def biggest_team_blowout(team_id)
    teams_hash[:goal_diffs][team_id].max
  end

  def worst_loss(team_id)
    teams_hash[:goal_diffs][team_id].min
  end

  def team_info(team_id)
    # require 'byebug'; byebug
    teams_hash[:teams_info][team_id]
  end

  def head_to_head(team_id)
    teams_hash[:win_pct_opp][team_id][:head_to_head]
  end

  def favorite_opponent(team_id)
    teams_hash[:win_pct_opp][team_id][:favorite_opponent]
  end

  def rival(team_id)
    teams_hash[:win_pct_opp][team_id][:rival]
  end

  def seasonal_summary(team_id)
    seasonal_summaries[team_id]
  end

  def best_season(team_id)
    teams_hash[:percent_wins][team_id].max_by { |k, v| v }[0]
  end

  def worst_season(team_id)
    teams_hash[:percent_wins][team_id].min_by { |k, v| v }[0]
  end

  def average_win_percentage(team_id)
    teams_hash[:average_wins][team_id]
  end

  def most_goals_scored(team_id)
    teams_hash[:max_min_goals][:highest_goals][team_id]
  end

  def fewest_goals_scored(team_id)
   teams_hash[:max_min_goals][:lowest_goals][team_id]
 end

  ###=== TEAM QUERIES ===###
end
