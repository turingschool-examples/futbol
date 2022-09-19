require 'csv'
require 'pry'
module TeamStatistics
  # Original method from Iteration 2
  def team_info(team_id)
    team_info_hash = Hash.new
    @teams.each do |team|
      if team[:team_id] == team_id
        team_info_hash['team_id'] = team[:team_id]
        team_info_hash['franchise_id'] = team[:franchiseid]
        team_info_hash['team_name'] = team[:teamname]
        team_info_hash['abbreviation'] = team[:abbreviation]
        team_info_hash['link'] = team[:link]
      end
    end
    team_info_hash
  end

  # Original method from Iteration 2
  def best_season(team_id)
    games_by_team_by_season(team_id)
    game_wins_by_team_by_season = Hash.new
    @games_by_team_by_season_hash.each do |season, games_by_team|
      game_wins_by_team_by_season[season] = ((games_by_team.count {|game| game[:result] == "WIN"}.to_f/games_by_team.length.to_f) * 100).round(2)
    end
    game_wins_by_team_by_season.key(game_wins_by_team_by_season.values.max)
  end

  # Original method from Iteration 2
  def worst_season(team_id)
    games_by_team_by_season(team_id)
    game_wins_by_team_by_season = Hash.new
    @games_by_team_by_season_hash.each do |season, games_by_team|
      game_wins_by_team_by_season[season] = ((games_by_team.count {|game| game[:result] == "WIN"}.to_f/games_by_team.length.to_f) * 100).round(2)
    end
    game_wins_by_team_by_season.key(game_wins_by_team_by_season.values.min)
  end

  # Original method from Iteration 2
  def average_win_percentage(team_id)
    games_by_team
    games_to_check = @games_by_team_hash[team_id]
    (games_to_check.count {|game| game[:result] == 'WIN'}.to_f / games_to_check.length.to_f).round(2)
  end

  # Original method from Iteration 2
  def most_goals_scored(team_id)
    games_by_team
    games_to_check = @games_by_team_hash[team_id]
    game_most_goals = games_to_check.max_by {|game| game[:goals].to_i}
    game_most_goals[:goals].to_i
  end

  # Original method from Iteration 2
  def fewest_goals_scored(team_id)
    games_by_team
    games_to_check = @games_by_team_hash[team_id]
    game_least_goals = games_to_check.min_by {|game| game[:goals].to_i}
    game_least_goals[:goals].to_i
  end

  # Original method from Iteration 2
  def favorite_opponent(team_id)
    opponent_win_loss = opponent_win_loss(team_id)

    favorite_opponent_id = opponent_win_loss.min_by{|opponent, win_loss| win_loss[0].to_f/win_loss[1]}[0]
    favorite_opponent = @teams.find do |team|
      team[:team_id] == favorite_opponent_id
    end
    favorite_opponent[:teamname]
  end

  # Original method from Iteration 2
  def rival(team_id)
    opponent_win_loss = opponent_win_loss(team_id)

    rival_id = opponent_win_loss.max_by{|opponent, win_loss| win_loss[0].to_f/win_loss[1]}[0]
    rival = @teams.find do |team|
      team[:team_id] == rival_id
    end
    rival[:teamname]
  end
end