module SeasonToTeamStats

  def seasonal_info(seasonid)
    reg_and_post_info = Hash.new
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
    bust = seasonal_info(seasonid).max_by do |team_id, season_type_hash|
      post_win_perc = season_type_hash[:postseason][:win_count] / season_type_hash[:postseason][:game_count].to_f
      post_win_perc = 0 unless season_type_hash[:postseason][:game_count] > 0
      reg_win_perc = season_type_hash[:regular_season][:win_count] / season_type_hash[:regular_season][:game_count].to_f
      reg_win_perc = 0 unless season_type_hash[:regular_season][:game_count] > 0
      reg_win_perc - post_win_perc
    end
    all_teams[bust[0]].team_name
  end

  def biggest_surprise(seasonid)
    bust = seasonal_info(seasonid).min_by do |team_id, season_type_hash|
      post_win_perc = season_type_hash[:postseason][:win_count] / season_type_hash[:postseason][:game_count].to_f
      post_win_perc = 0 unless season_type_hash[:postseason][:game_count] > 0
      reg_win_perc = season_type_hash[:regular_season][:win_count] / season_type_hash[:regular_season][:game_count].to_f
      reg_win_perc = 0 unless season_type_hash[:regular_season][:game_count] > 0
      reg_win_perc - post_win_perc
    end
    all_teams[bust[0]].team_name
  end
end
