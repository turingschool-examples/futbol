module SeasonStatistics

  def find_all_seasons
    seasons = []
    @game_table.each do |game_id, game|
      if !seasons.include?(game.season)
        seasons << game.season
      end
    end
    seasons
  end

  def coaches_per_season(seasons)
    coaches_per_season = {}
    game_table = @game_table
    seasons.each do |season|
      @game_team_table.each do |game|
        if game_table[(game.game_id).to_s].season == season
          if coaches_per_season[season].nil?
            coaches_per_season[season] = {game.head_coach => [game.result]}
          elsif coaches_per_season[season][game.head_coach]
            coaches_per_season[season][game.head_coach] << game.result
          else
            coaches_per_season[season][game.head_coach] = [game.result]
          end
        end
      end
    end
    coaches_per_season
  end

  def winningest_coach(season)
    season_coach_hash = coaches_per_season(find_all_seasons)
    winningest_coach_name = nil
    highest_percentage = 0
    season_coach_hash[season].each do |key, value|
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
        end
      end
      # require "pry"; binding.pry
      # p " #{key} +  #{(total_wins.to_f / total_games).round(2)}"
      # p " #{key} +  wins: #{total_wins}, losses:#{total_losses}, ties:#{total_ties}, total games:#{total_games}"
      if (total_wins.to_f / total_games) > highest_percentage && total_games > 5
        highest_percentage = (total_wins.to_f ) / total_games
        winningest_coach_name = key
      end
    end
    winningest_coach_name
  end

  # def worst_coach(season)
  #   worst_coach_name = nil
  #   lowest_percentage = 0
  #   @season_coach_hash[season].each do |key, value|
  #     total_games = 0
  #     total_wins = 0
  #     total_losses = 0
  #     total_ties = 0
  #     value.each do |game_result|
  #       total_games += 1
  #       if game_result == "WIN"
  #         total_wins += 1
  #       elsif game_result == "LOSS"
  #         total_losses += 1
  #       elsif game_result == "TIE"
  #         total_ties += 1
  #       else
  #         p "Unexpected game result: #{game_result}"
  #       end
  #     end
  #     # p " #{key} +  #{(total_wins.to_f / total_games).round(5)}"
  #     if (total_wins.to_f / total_games) <= lowest_percentage
  #       lowest_percentage = (total_wins.to_f / total_games)
  #       worst_coach_name = key
  #     end
  #   end
  #   @stat_tracker_copy.worst_coach = worst_coach_name
  # end
  #
  # def team_shots_and_goals_hash
  #   team_shots_and_goals ={}
  #   hash_by_team_id = {}
  #   @csv_game_teams_table.each do |game_id, game_team|
  #     team_shots_and_goals[game_id] = {}
  #     team_shots_and_goals[game_id][game_team.team_id] = [game_team.shots, game_team.goals]
  #
  #     hash_by_team_id[game_team.team_id] = [game_team.shots, game_team.goals]
  #   end
  # end
  #

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
