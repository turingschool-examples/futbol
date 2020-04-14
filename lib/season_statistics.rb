require 'pry'

class SeasonStatistics
attr_reader :game_collection

  def initialize(game_collection, game_teams_collection, teams_collection)
    @game_collection = game_collection
    @game_teams_collection = game_teams_collection
    @teams_collection = teams_collection
  end

  def current_season_game_ids(season)
    season_game_ids = @game_collection.map do |game|
      game.game_id if game.season == season
    end
    season_game_ids.compact
  end

  def current_season_game_teams(season)
    @game_teams_collection.find_all do |game|
      current_season_game_ids(season).include?(game.game_id)
    end
  end

  # def current_season_games(season)
  #   current_games = @game_collection.map do |game|
  #    if game.season == season
  #      game.game_id
  #    end
  #  end
  # current_games.compact
  # end

  def team_ids(season)
    current_season_game_teams(season).map do |game|
      game.team_id
    end
  end

  def teams_hash(season)
    season_team_ids = team_ids(season)
    team_names = Hash.new(0)
    @teams_collection.each do |team|
      (teams_names[team.id] = 0) if season_team_ids.include?(team.id)
      end
    team_names
  end

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

  def coaches_hash(season)
    coaches = Hash.new(0)
    season_coaches = current_season_game_teams(season).map do |game|
      game.head_coach
    end
    @game_teams_collection.each do |team|
        if season_coaches.include?(team.head_coach)
          coaches[team.head_coach] = 0
        end
      end
    coaches
  end

  # def current_season_game_teams(season)
  #   season_games = current_season_games(season)
  #   @game_teams_collection.find_all do |game|
  #   season_games.include?(game.game_id)
  #   end
  # end

  def coach_win_loss_results(season, high_low)
    coaches_win = coaches_hash(season)
    coaches_total = coaches_hash(season)
    current_season_game_teams(season).each do |game|
      if game.result == "WIN"
        coaches_win[game.head_coach] += 1
        coaches_total[game.head_coach] += 1
      elsif game.result == "LOSS"
        coaches_total[game.head_coach] += 1
      elsif game.result == "TIE"
        coaches_total[game.head_coach] += 1
      end
    end
    if high_low == "high"
      percentage_wins = coaches_win.to_h do |key, value|
        [key, (value.to_f/coaches_total[key])]
      end
        percentage_wins.max_by{|k,v| v}[0]
      # winning_coach = coaches_win.max_by {|coach| coach[1]}
      # winning_coach[0]
    elsif high_low == "low"
      percentage_wins = coaches_win.to_h do |key, value|
        [key, (value.to_f/coaches_total[key])]
      end
      percentage_wins.min_by{|k,v| v}[0]
      # losing_coach = coaches_lose.max_by {|coach| coach[1]}
      # losing_coach[0]
    end
  end

  def most_least_tackles(season, high_low)
    teams = teams_hash(season)
    current_season_game_teams(season).each do |game|
      teams[game.team_id] += game.tackles
    end
    if high_low == "high"
      most_tackles = teams.max_by {|team| team[1]}
      highest_team = @teams_collection.find {|team| team.id == most_tackles[0]}
      highest_team.team_name
    elsif high_low == "low"
      fewest_tackles = teams.min_by {|team| team[1]}
      lowest_team = @teams_collection.find {|team| team.id == fewest_tackles[0]}
      lowest_team.team_name
    end
  end

  def team_accuracy(season, high_low)
    team_goals = teams_hash(season)
    team_shots = teams_hash(season)
    current_season_game_teams(season).each do |game|
      team_goals[game.team_id] += game.goals
      team_shots[game.team_id] += game.shots
    end
    if high_low == "high"
      ratio_shots_goals = team_goals.to_h do |key, value|
        [key, (value.to_f/team_shots[key])]
      end
        ratio_team_id = ratio_shots_goals.max_by{|k,v| v}[0]
        most_accurate = @teams_collection.find {|team| team.id == ratio_team_id[0]}

        most_accurate.team_name
    elsif high_low == "low"
      ratio_shots_goals = team_goals.to_h do |key, value|
        [key, (value.to_f/team_shots[key])]
      end
      ratio_team_id = ratio_shots_goals.min_by{|k,v| v}[0]
      least_accurate = @teams_collection.find {|team| team.id == ratio_team_id[0]}

      least_accurate.team_name
    end
  end
end
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
