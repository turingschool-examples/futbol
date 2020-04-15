require_relative './statistics'
require_relative './keyable'

class SeasonStatistics < Statistics
attr_reader :game_collection
include Keyable

#returns array of game ids for given season
#try using find all and then map as opposed to compact
  def current_season_game_ids(season)
    season_game_ids = @game_collection.map do |game|
      game.game_id if game.season == season
    end
    season_game_ids.compact
  end


  #returns an array of game_team objects in given season
    def current_season_game_teams(season)
      season_games = current_season_game_ids(season)
      @game_teams_collection.find_all do |game|
        season_games.include?(game.game_id)
      end
    end

  #   def current_season_game_teams(season)
  #     current_season_game_ids
  #   bob ||= @game_teams_collection.find_all do |game|
  #     games[season].include?(game.game_id)
  #     end
  #     binding.pry
  # end


# returns an array of game_team objects in given season

  # def current_season_game_teams(season)
  #   season_game_ids = current_season_game_ids(season)
  #   @games_by_season ||= @game_collection.group_by {|game| game.season}
  #
  #   @games_by_season[season].map do |k,v|
  #     if v.map do |value|
  #       if value.game_id == @game_teams_collection.game_id
  #
  # end

#returns an array of all team ids within givin season
  def team_ids(season)
    current_season_game_teams(season).map do |game|
      game.team_id
    end
  end

#returns hash of team names set to the value zero
  def team_ids_hash(season)
    season_team_ids = team_ids(season)
    team_id = Hash.new(0)
    @teams_collection.each do |team|
      (team_id[team.id] = 0) if season_team_ids.include?(team.id)
    end
    team_id
  end

#Should consider this method for parent class
#returns hash of team ids as keys and team names as values
  def team_name_hash
    @teams_collection.to_h do |team|
      [team.id, team.team_name]
    end
  end

#returns array of names for all the coaches within a given season
  def coach_names(season)
    current_season_game_teams(season).map do |game|
      game.head_coach
    end
  end

#returns a hash of season coaches as keys set to the value zero
  def coaches_hash(season)
    season_coaches = coach_names(season)
    coaches = Hash.new(0)

   current_season_game_teams(season).each do |team|
      (coaches[team.head_coach] = 0) if season_coaches.include?(team.head_coach)
    end
    coaches
  end

#returns hash of team id as keys and total tackles in season as value
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
    high_low_key_return(team_tackles, high_low)
    team_name_hash[@chosen_key]
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
    high_low_key_return(acc_hash, high_low)
    team_name_hash[@chosen_key]
  end
end
