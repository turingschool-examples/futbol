require_relative './statistics'
require_relative './keyable'

class SeasonStatistics < Statistics
  include Keyable
  attr_reader :game_collection

  def current_season_game_ids(season)
    season_game_ids = @game_collection.map do |game|
      game.game_id if game.season == season
    end
    season_game_ids.compact
  end

  def current_season_game_teams(season)
    season_games = current_season_game_ids(season)
    if @games_by_season.has_key?(season)
      @games_by_season[season]
    else
      @games_by_season[season] = @game_teams_collection.find_all do |game|
        season_games.include?(game.game_id)
      end
    end
  end

  def team_ids(season)
    current_season_game_teams(season).map do |game|
      game.team_id
    end
  end

  def team_ids_hash(season)
    season_team_ids = team_ids(season)
    team_id = Hash.new(0)
    @teams_collection.each do |team|
      (team_id[team.id] = 0) if season_team_ids.include?(team.id)
    end
    return team_id
  end

  def team_name_hash
    @teams_collection.to_h do |team|
      [team.id, team.team_name]
    end
  end

  def coach_names(season)
     current_season_game_teams(season).map do |game|
      game.head_coach
    end
  end

  def coaches_hash(season)
    season_coaches = coach_names(season)
    coaches = Hash.new(0)
    current_season_game_teams(season).each do |team|
      (coaches[team.head_coach] = 0) if season_coaches.include?(team.head_coach)
    end
    coaches
  end

  def team_tackles_hash(season)
    team_tackles = team_ids_hash(season)
    current_season_game_teams(season).each do |game|
      team_tackles[game.team_id] += game.tackles
    end
    team_tackles
  end

  def coach_win_loss_results(season, high_low)
    coach_wins = coaches_hash(season)
    coach_totals = coaches_hash(season)
    current_season_game_teams(season).each do |game|
      if game.result == "WIN"
        coach_wins[game.head_coach] += 1
        coach_totals[game.head_coach] += 1
      elsif game.result == "LOSS"
        coach_totals[game.head_coach] += 1
      elsif game.result == "TIE"
        coach_totals[game.head_coach] += 1
      end
    end
    percentage_wins = coach_wins.to_h do |key, value|
      [key, (value.to_f/coach_totals[key])]
    end
    high_low_key_return(percentage_wins, high_low)
  end

  def most_least_tackles(season, high_low)
    team_tackles = team_tackles_hash(season)
    team_name_hash[high_low_key_return(team_tackles, high_low)]
  end

  def team_accuracy(season, high_low)
    team_goals = team_ids_hash(season)
    team_shots = team_ids_hash(season)
    current_season_game_teams(season).each do |game|
      team_goals[game.team_id] += game.goals
      team_shots[game.team_id] += game.shots
    end
    acc_hash = team_ids(season).to_h do |id|
      [id, (team_goals[id] / team_shots[id].to_f)]
    end
    team_name_hash[high_low_key_return(acc_hash, high_low)]
  end
end
