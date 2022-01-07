require './lib/managers/game_teams_manager'
require 'pry'
# THIS IS MICHAEL'S
# Season Statistics
class SeasonStatistics
  attr_reader :gtmd
  def initialize(game_team_manager)
    @gtmd = game_team_manager # accronym for gameteammanagerdata
  end
  def winningest_coach(season_id)
    season_coaches(season_id).max_by {|coach| coaches_by_win_percentage(season_id, coach) }
  end

  def worst_coach(season_id)
    season_coaches(season_id).min_by {|coach| coaches_by_win_percentage(season_id, coach) }

  end

  def most_accurate_team(season_id)
    # Name of the Team with the best ratio of shots to goals for the season (String)
    season_teams(season_id).max_by {|team| teams_by_accuracy(season_id, team) }
    # needs to be converted to string with data from team_manager
  end

  def least_accurate_team(season_id)
    season_teams(season_id).min_by {|team| teams_by_accuracy(season_id, team) }
  end

  def most_tackles(season_id)
    # Name of the Team with the most tackles in the season (String)
    season_teams(season_id).max_by {|team| tackles_by_team(season_id, team) }
    # needs to be converted to string with data from team_manager
  end

  def fewest_tackles(season_id)
    season_teams(season_id).min_by {|team| tackles_by_team(season_id, team) }
  end

  ## Necessary helper methods for above result methods

  def season_coaches(season_id)
    game_teams_data_by_season(season_id).map { |game| game.head_coach }.uniq
  end

  def game_teams_data_by_season(season_id)
    @gtmd.data.find_all {|game| game.game_id[0..3] == season_id[0..3]}
  end

  def coaches_by_win_percentage(season_id, coach)
    won_games_by_coach = []
    count = 0
    game_teams_data_by_season(season_id).each do |game|
      won_games_by_coach << game if game.head_coach == coach && game.result == 'WIN'
      count += 1 if game.head_coach == coach
    end
    ((won_games_by_coach.count.to_f / count) * 100).round(2)
  end

  def season_teams(season_id)
    game_teams_data_by_season(season_id).map { |game| game.team_id }.uniq
  end

  def teams_by_accuracy(season_id, team)
    total_shots = 0
    total_goals = 0
    game_teams_data_by_season(season_id).each do |game|
      total_shots += game.shots if game.team_id == team
      total_goals += game.goals if game.team_id == team
    end
    ((total_goals.to_f / total_shots) * 100).round(2)
  end

  def tackles_by_team(season_id, team)
    total_tackles = 0
    game_teams_data_by_season(season_id).each do |game|
      total_tackles += game.tackles if game.team_id == team
    end
    return total_tackles
  end

  # Aedan's methods
  def matching_teams(team_id)
    @gtmd.data.find_all do |game|
      team_id == game.team_id
    end
  end

  def total_games(team_id)
    matching_teams(team_id).count
  end

  def win_percentage(team_id)
    wins = matching_teams(team_id).find_all {|team| team.result == "WIN" }
    (wins.count.to_f/total_games(team_id)) * 100
  end
end



a = SeasonStatistics.new($game_team_manager_data)
