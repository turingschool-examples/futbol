module SeasonToTeamStats

  def seasonal_info(seasonid)
    reg_and_post_info = Hash.new
    # get info from all_game_team
    games_in_season = all_games.map do |game_id, game_obj|
      game_obj if game_obj.season == seasonid
    end.compact
    games_in_season.each do |game|
      season_type = game.type.gsub(" ", "_").downcase.to_sym
      all_game_teams[game.game_id].each do |home_away, gt_obj|
        reg_and_post_info[gt_obj.team_id] ||= {
          postseason: {
            game_count: 0,
            win_count: 0,
            goal_count: 0,
            shot_count: 0,
            tackle_count: 0,
          },
          regular_season: {
            game_count: 0,
            win_count: 0,
            goal_count: 0,
            shot_count: 0,
            tackle_count: 0,
          }
        }
        reg_and_post_info[gt_obj.team_id][season_type][:game_count] += 1
        reg_and_post_info[gt_obj.team_id][season_type][:win_count] += 1 if gt_obj.result == 'WIN'
        reg_and_post_info[gt_obj.team_id][season_type][:goal_count] += gt_obj.goals
        reg_and_post_info[gt_obj.team_id][season_type][:shot_count] += gt_obj.shots
        reg_and_post_info[gt_obj.team_id][season_type][:tackle_count] += gt_obj.tackles
      end
    end
    reg_and_post_info
  end

  def biggest_bust(seasonid)
  end
end
