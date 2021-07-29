require 'csv'

module GamesProcessor
  def best_season(team_id)
    get_season_averages(team_id).max_by do |season, average|
      average
    end.first
  end

  def worst_season(team_id)
    get_season_averages(team_id).min_by do |season, average|
      average
    end.first
  end

  def get_season_averages(team_id)
    season_average = seasons_win_count(team_id)
    season_average.map do |season, stats|
      [season, stats[:wins].fdiv(stats[:total])]
    end.to_h
  end

  def seasons_win_count(team_id, games)
    season_average = {}
    games.each do |game|
      season = game[:season]
      if game[:home_team_id] == team_id || game[:away_team_id] == team_id
        data = get_home_or_away(team_id, game)

        season_average[season] ||= {wins: 0, total: 0}
        if data[:team_goals] > data[:opp_goals]
          season_average[season][:wins] += 1
        end
        season_average[season][:total] += 1
      end
    end
    season_average
  end

  def rival(team_id)
    win_loss = calculate_win_percents(team_id)
    rival_team = win_loss.min_by do |team, result|
      result
    end.first

    team_info(rival_team)["team_name"]
  end


  def percentage_home_wins
    home_game_wins = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] > game[:away_goals]
        home_game_wins += 1
      end
    end
    (home_game_wins.fdiv(total_games)).round(2)
  end

  def percentage_visitor_wins
    visitor_game_wins = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] < game[:away_goals]
        visitor_game_wins += 1
      end
    end
    (visitor_game_wins.fdiv(total_games)).round(2)
  end

  def percentage_ties
    ties = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] == game[:away_goals]
        ties += 1
      end
    end
    (ties.fdiv(total_games)).round(2)
  end



  def get_away_team_goals
    away_avg = {}
    @games.each do |game|
      away_avg[game[:away_team_id]] ||= { goals: 0, total: 0 }
      away_avg[game[:away_team_id]][:goals] += game[:away_goals].to_i
      away_avg[game[:away_team_id]][:total] += 1
    end
    away_avg
  end

  def highest_scoring_visitor
    away_info = get_away_team_goals
    team_id = away_info.each.max_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_info(team_id)['team_name']
  end

  def lowest_scoring_visitor
    away_info = get_away_team_goals
    team_id = away_info.each.min_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_info(team_id)['team_name']
  end

  def get_home_team_goals
    home_avg = {}
    @games.each do |game|
      home_avg[game[:home_team_id]] ||= { goals: 0, total: 0 }
      home_avg[game[:home_team_id]][:goals] += game[:home_goals].to_i
      home_avg[game[:home_team_id]][:total] += 1
    end
    home_avg
  end

  def highest_scoring_home_team
    home_info = get_home_team_goals
    team_id = home_info.each.max_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_info(team_id)['team_name']
  end

  def lowest_scoring_home_team
    home_info = get_home_team_goals
    team_id = home_info.each.min_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_info(team_id)['team_name']
  end
end
