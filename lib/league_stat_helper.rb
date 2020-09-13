class LeagueStatHelper

  def team_name_ids
    team_name_per_team_id = {}
    @team.each do |team_id, team|
      team_name_per_team_id[team.team_name] = team_id
    end
    team_name_per_team_id
  end

  def team_season_average
    season_average = {}
    team_name_ids.each do |team_name, team_id|
      game_count = 0
      @game.each do |game_id, game|
        if team_id.to_i == game.away_team_id && season_average[team_name].nil?
          season_average[team_name] = game.away_goals
          game_count += 1
        elsif team_id.to_i == game.home_team_id && season_average[team_name].nil?
          season_average[team_name] = game.home_goals
          game_count += 1
        elsif team_id.to_i == game.home_team_id || team_id.to_i == game.away_team_id
          game_count += 1
          season_average[team_name] += game.away_goals if team_id.to_i == game.away_team_id
          season_average[team_name] += game.home_goals if team_id.to_i == game.home_team_id
        end
      end
      season_average[team_name] = season_average[team_name]/game_count.to_f
    end
    season_average
  end

  def team_away_average
    team_away_average = {}
    team_name_ids.each do |team_name, team_id|
      game_count = 0
      @game.each do |game_id, game|
        if team_id.to_i == game.away_team_id && team_away_average[team_name].nil?
           team_away_average[team_name] = game.away_goals
           game_count += 1
        elsif team_id.to_i == game.away_team_id
          team_away_average[team_name] += game.away_goals
          game_count += 1
        end
      end
      team_away_average[team_name] = team_away_average[team_name]/game_count.to_f
    end
    team_away_average
  end

  def team_home_average
    team_home_average = {}
    team_name_ids.each do |team_name, team_id|
      game_count = 0
      @game.each do |game_id, game|
        if team_id.to_i == game.home_team_id && team_home_average[team_name].nil?
           team_home_average[team_name] = game.home_goals
           game_count += 1
        elsif team_id.to_i == game.home_team_id
          team_home_average[team_name] += game.home_goals
          game_count += 1
        end
      end
      team_home_average[team_name] = team_home_average[team_name]/game_count.to_f
    end
    team_home_average
  end

end
