require 'pry'

class SeasonStatistics
attr_reader :game_collection

  def initialize(game_collection, game_teams_collection, teams_collection)
    @game_collection = game_collection
    @game_teams_collection = game_teams_collection
    @teams_collection = teams_collection
  end

#returns array of game ids for given season
  def current_season_game_ids(season)
    season_game_ids = @game_collection.map do |game|
      game.game_id if game.season == season
    end
    season_game_ids.compact
  end

#returns an array of game_team objects in given season
  def current_season_game_teams(season)
    @game_teams_collection.find_all do |game|
      current_season_game_ids(season).include?(game.game_id)
    end
  end

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
    @game_teams_collection.each do |team|
      (coaches[team.head_coach] = 0) if season_coaches.include?(team.head_coach)
    end
    coaches
  end

#takes hash and returns key associated with max value
#neccessary?
#parent method?
  def key_for_max_val(hash)
      hash.max_by {|k,v| v}[0]
  end

#takes hash and returns key associated with min value
#neccessary?
#parent method?
  def key_for_min_val(hash)
      hash.min_by {|k,v| v}[0]
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
    if high_low == "high"
      percentage_wins = coach_wins.to_h do |key, value|
        [key, (value.to_f/coach_totals[key])]
      end
        percentage_wins.max_by{|k,v| v}[0]
    elsif high_low == "low"
      percentage_wins = coach_wins.to_h do |key, value|
        [key, (value.to_f/coach_totals[key])]
      end
      percentage_wins.min_by{|k,v| v}[0]
    end
  end

  def most_least_tackles(season, high_low)
    team_tackles = team_tackles_hash(season)
    if high_low == "high"
      most_tackles = team_tackles.max_by {|k,v| v}[0]
      team_name_hash[most_tackles]
    elsif high_low == "low"
      fewest_tackles = team_tackles.min_by {|k,v| v}[0]
      team_name_hash[fewest_tackles]
    end
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
    if high_low == "high"
      most_acc = acc_hash.max_by {|k,v| v}[0]
      team_name_hash[most_acc]
    elsif high_low == "low"
      least_acc = acc_hash.min_by {|k,v| v}[0]
      team_name_hash[least_acc]
    end
  end
end 

    # if high_low == "high"
    #   ratio_shots_goals = team_goals.to_h do |key, value|
    #     [key, (value.to_f/team_shots[key])]
    #   end
    #     ratio_team_id = ratio_shots_goals.max_by{|k,v| v}[0]
    #     most_accurate = @teams_collection.find {|team| team.id == ratio_team_id[0]}
    #
    #     most_accurate.team_name
    # elsif high_low == "low"
    #   ratio_shots_goals = team_goals.to_h do |key, value|
    #     [key, (value.to_f/team_shots[key])]
    #   end
    #   ratio_team_id = ratio_shots_goals.min_by{|k,v| v}[0]
    #   least_accurate = @teams_collection.find {|team| team.id == ratio_team_id[0]}
    #
    #   least_accurate.team_name
    # end
#   end
# end
    #hash of team id as keys and games they have played as values

  #   teams = current_season_game_teams(season).group_by do |game|
  #   game.team_id
  #   end
  #   team_accuracy_hash = teams.to_h do |key,value|
  #     total_goals = 0
  #     total_shots = 0
  #     value.each do |game|
  #       total_goals += game.goals
  #       total_shots += game.shots
  #     end
  #     [key,(total_goals / total_shots.to_f)]
  #   end
  #   most_accurate = team_accuracy_hash.max_by {|key, value| key}
  #   most_accurate_name = @teams_collection.find {|team| team.id == most_accurate[0]}
  #   most_accurate_name.team_name
  # end

    # def most_accurate_team(season)
    #   teams = current_season_game_teams(season).group_by do |game|
    #   game.team_id
    #   end
    #   accuracy = teams.to_h do |key, value|
    #     [key, value.map {|game| (game.goals / game.shots.to_f)}]
    #     #this needs to be refactored so total accuracy isn't above 1.
    #   end
    #   final = accuracy.to_h do |key, value|
    #     [key, value.sum {|team| team }]
    #   end
    #   most_accurate = final.max_by {|team| team}
    #   most_accurate_name = @teams_collection.find {|team| team.id == most_accurate[0]}
    #   most_accurate_name.team_name
    # end

    # def least_accurate_team(season)
    #   #hash of team id as keys and games they have played as values
    #   teams = current_season_game_teams(season).group_by do |game|
    #   game.team_id
    #   end
    #   team_accuracy_hash = teams.to_h do |key,value|
    #     total_goals = 0
    #     total_shots = 0
    #     value.each do |game|
    #       total_goals += game.goals
    #       total_shots += game.shots
    #     end
    #     [key,(total_goals / total_shots.to_f)]
    #   end
    #   least_accurate = team_accuracy_hash.min_by {|key, value| key}
    #   least_accurate_name = @teams_collection.find {|team| team.id == least_accurate[0]}
    #   least_accurate_name.team_name
    # end

    # def least_accurate_team(season)
    #   teams = current_season_game_teams(season).group_by do |game|
    #   game.team_id
    #   end
    #   accuracy = teams.to_h do |key, value|
    #     [key, value.map {|game| (game.goals / game.shots.to_f)}]
    #     #this needs to be refactored so total accuracy isn't above 1.
    #   end
    #   final = accuracy.to_h do |key, value|
    #     [key, value.sum {|team| team }]
    #   end
    #   least_accurate = final.min_by {|team| team}
    #   least_accurate_name = @teams_collection.find {|team| team.id == least_accurate[0]}
    #   least_accurate_name.team_name
    # end




    # def current_season_games(season)
    #   current_games = @game_collection.map do |game|
    #    if game.season == season
    #      game.game_id
    #    end
    #  end
    # current_games.compact
    # end

    # def teams_hash(season)
    #   season_team_ids = team_ids (season)
    #   team_names = Hash.new(0)
    #   @teams_collection.each do |team|
    #       if season_teams.include?(team.id)
    #         teams[team.id] = 0
    #       end
    #     end
    #   teams
    # end

    # def current_season_game_teams(season)
    #   season_games = current_season_games(season)
    #   @game_teams_collection.find_all do |game|
    #   season_games.include?(game.game_id)
    #   end
    # end
