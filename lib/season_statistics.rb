require_relative "stat_tracker"

class SeasonStatistics
  attr_reader :stat_tracker_copy
  def initialize(stat_tracker)
    @csv_game_teams_table = stat_tracker.game_teams
    @csv_games_table = stat_tracker.games
    @csv_teams_table = stat_tracker.teams
    @stat_tracker_copy = stat_tracker
    @season_coach_hash = coach_game_results
  end

  def map_season_to_game_ids
    season_game_id_hash = {}
    @csv_games_table.each do |game_id, game|
      # if game.type = "Regular Season"
        season_game_id_hash[game_id] = game.season
      # end
    end
    season_game_id_hash
  end

  def find_all_seasons
    seasons = []
    @csv_games_table.each do |game_id, game|
      if !seasons.include?(game.season)
        seasons << game.season
      end
    end
    seasons
  end

  def coach_game_results
    seasons = find_all_seasons
    season_game_id_hash = map_season_to_game_ids
    season_coach_hash = {}

    seasons.each do |season|
      coach_results_hash = {}
      @csv_game_teams_table.each do |game_id, game_team|
        require "pry"; binding.pry
        if season_game_id_hash[game_id] == season
          if coach_results_hash[game_team.head_coach]
            coach_results_hash[game_team.head_coach] << game_team.result
          else
            coach_results_hash[game_team.head_coach] = [game_team.result]
          end
        end
      end
      season_coach_hash[season] = coach_results_hash
    end
    season_coach_hash
  end

  def winningest_coach(season)
    winningest_coach_name = nil
    highest_percentage = 0
    @season_coach_hash[season].each do |key, value|
      total_games = 0
      total_wins = 0
      total_losses = 0
      total_ties = 0
      value.each do |game_result|
        total_games += 1
        if game_result == "WIN"
          total_wins += 1
        elsif game_result == "LOSS"
          total_losses += 1
        elsif game_result == "TIE"
          total_ties += 1
        else
          p "Unexpected game result: #{game_result}"
        end
      end
      # p " #{key} +  #{(total_wins.to_f / total_games).round(5)}"
      # p " #{key} +  wins: #{total_wins}, losses:#{total_losses}, ties:#{total_ties}, total games:#{total_games}"
      if (total_wins.to_f / total_games) > highest_percentage
        highest_percentage = (total_wins.to_f ) / total_games
        winningest_coach_name = key
      end
    end
    # require "pry"; binding.pry
    @stat_tracker_copy.winningest_coach = winningest_coach_name
  end

  def worst_coach(season)
    worst_coach_name = nil
    lowest_percentage = 0
    @season_coach_hash[season].each do |key, value|
      total_games = 0
      total_wins = 0
      total_losses = 0
      total_ties = 0
      value.each do |game_result|
        total_games += 1
        if game_result == "WIN"
          total_wins += 1
        elsif game_result == "LOSS"
          total_losses += 1
        elsif game_result == "TIE"
          total_ties += 1
        else
          p "Unexpected game result: #{game_result}"
        end
      end
      # p " #{key} +  #{(total_wins.to_f / total_games).round(5)}"
      if (total_wins.to_f / total_games) <= lowest_percentage
        lowest_percentage = (total_wins.to_f / total_games)
        worst_coach_name = key
      end
    end
    @stat_tracker_copy.worst_coach = worst_coach_name
  end

  def team_shots_and_goals_hash
    team_shots_and_goals ={}
    hash_by_team_id = {}
    @csv_game_teams_table.each do |game_id, game_team|
      team_shots_and_goals[game_id] = {}
      team_shots_and_goals[game_id][game_team.team_id] = [game_team.shots, game_team.goals]

      hash_by_team_id[game_team.team_id] = [game_team.shots, game_team.goals]
    end
  end


  # def most_accurate_team(season)
  #   seasons = find_all_seasons
  #   season_game_id_hash = map_season_to_game_ids
  #   team_shots_and_goals_hash ={}
  #   best_shots_percentage = 0
  #   best_shots_team = nil
  #   @csv_game_teams_table.each do |game_id, game_team|
  #     team_shots_and_goals_hash[game_id] = [game_team.shots, game_team.goals]
  #   end
  #   shots = 0
  #   goals = 0
  #   team_shots_and_goals_hash.each do |game_id, shots_and_goals|
  #     if season_game_id_hash[game_id] == season
  #       shots += shots_and_goals[0]
  #       goals += shots_and_goals[1]
  #     end
  #     if goals.to_f/shots.to_f > best_shots_percentage
  #       best_shots_percentage = goals.to_f/shots.to_f
  #       best_shots_team = game_id
  #     end
  #   end
  #   best_shots_team
  #   end
  #   @stat_tracker_copy.most_accurate_team = get_team_name_from_game_id(best_shots_team)
  # end
  #
  # def get_team_name_from_game_id(game_id)
  #   @csv_game_teams_table.find do |game_id, game_info|
  #     if game_info.game_id == game_id
  #        game_info.team_id
  #      end
  #        require "pry"; binding.pry
  #       @csv_teams_table.find do |team_id, info|
  #         name = info.team_name
  #       end
  #
  # end

end
