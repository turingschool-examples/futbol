module SeasonalSumaryStat

  def seasonal_summary_helper(team_id)
    team_game_id = 0
    season_games = Hash.new
    all_game_teams.each do |game_id, hash_pair|
      hash_pair.each do |key, game_team_obj|
        if team_id == game_team_obj.team_id
          team_game_id = game_team_obj.game_id
          season_games[all_games[team_game_id].season] ||= {postseason: [], regular_season: []}
          if all_games[team_game_id].type == 'Postseason'
            season_games[all_games[team_game_id].season][:postseason] << game_team_obj
          elsif all_games[team_game_id].type == 'Regular Season'
            season_games[all_games[team_game_id].season][:regular_season] << game_team_obj
          end
        end
      end
    end
    season_games
  end

  def seasonal_summary(team_id)
    summary_hash = Hash.new
    summary_hash[:regular_season] ||= {
        win_percentage: 0,
        total_goals_scored: 0,
        total_goals_against: 0,
        average_goals_scored: 0,
        average_goals_against: 0
      }

    summary_hash[:postseason] ||= {
      win_percentage: 0,
      total_goals_scored: 0,
      total_goals_against: 0,
      average_goals_scored: 0,
      average_goals_against: 0
    }
    seasonal_summary_helper(team_id).each do |seasonid, hash_pair|
      hash_pair.each do |pre_post_keys, game_team_obj_array|
        summary_hash[pre_post_keys][:total_goals_scored] +=
          game_team_obj_array.sum {|game_team_obj| game_team_obj.goals}
        summary_hash[pre_post_keys][:average_goals_scored] = (summary_hash[pre_post_keys][:total_goals_scored] / game_team_obj_array.length.to_f).round(2)
        if game_team_obj_array.any? {|game_team_obj| game_team_obj.result == "WIN"}
          summary_hash[pre_post_keys][:win_percentage] =
            (game_team_obj_array.count {|game_team_obj| game_team_obj.result == "WIN"} / game_team_obj_array.length.to_f).round(2)
        else
          summary_hash[pre_post_keys][:win_percentage] = 0
        end
        opponent_gts = opponent_summary(team_id, game_team_obj_array)
        summary_hash[pre_post_keys][:total_goals_against] += opponent_gts.sum {|game_team_obj| game_team_obj.goals}
        summary_hash[pre_post_keys][:average_goals_against] = (summary_hash[pre_post_keys][:total_goals_against] / game_team_obj_array.length.to_f).round(2)
      end
    end
    summary_hash
    binding.pry
  end

  def opponent_summary(team_id, gt_array)
    relevant_games = gt_array.map do |game_team_obj|
      game_team_obj.game_id
    end
    oppo_game_teams = relevant_games.map do |game_id|
      all_game_teams[game_id].values
    end
    oppo_game_teams.flatten!
    oppo_game_teams.reject {|gt_obj| gt_obj.team_id == team_id}
  end


    #     if game.home_team_id == team_id
    #       if game.type == 'Postseason'
    #         summary_hash[:postseason][:total_goals_scored] += game.home_goals
    #         summary_hash[:postseason][:total_goals_against] += game.away_goals
    #       else
    #         summary_hash[:regular_season][:total_goals_scored] += game.home_goals
    #         summary_hash[:regular_season][:total_goals_against] += game.away_goals
    #       end
    #     elsif game.away_team_id == team_id
    #       if game.type == 'Postseason'
    #         summary_hash[:postseason][:total_goals_scored] += game.away_goals
    #         summary_hash[:postseason][:total_goals_against] += game.home_goals
    #       else
    #         summary_hash[:regular_season][:total_goals_scored] += game.away_goals
    #         summary_hash[:regular_season][:total_goals_against] += game.home_goals
    #       end
    #     end
    #   end
    # summary_hash[:regular_season][:average_goals_scored] = (summary_hash[:postseason][:total_goals_scored] / relavent_games.length.to_f).round(2)
    # summary_hash[:regular_season][:average_goals_scored] = (summary_hash[:postseason][:total_goals_scored] / relavent_games.length.to_f).round(2)
    # summary_hash[:postseason][:average_goals_against] = (summary_hash[:postseason][:total_goals_against] / relavent_games.length.to_f).round(2)
    # summary_hash[:postseason][:average_goals_against] = (summary_hash[:postseason][:total_goals_against] / relavent_games.length.to_f).round(2)
    # summary_hash
  # end
end
