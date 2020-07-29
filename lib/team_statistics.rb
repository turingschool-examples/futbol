require "./module/calculatable"
class TeamStatistics
  include Calculatable

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def team_info(team_id)
    team_info_hash(team_id, @teams)
  end

  def average_win_percentage(team_id)
    average_win_method(team_id, @game_teams)
  end

  def best_season(team_id)
    results = win_hash(team_id)
    best = results.max_by do |season, games|
      results[season].first / results[season].last.to_f
    end
    math = best[0].to_i
    math += 1
    math.to_s
    answer = best.first + "#{math}"
  end

  def worst_season(team_id)
    results = win_hash(team_id)
    worst = results.min_by do |season, games|
      results[season].first / results[season].last.to_f
    end
    math = worst[0].to_i
    math += 1
    math.to_s
    answer = worst.first + "#{math}"
  end

  def win_hash(team_id)
    win_count = Hash.new(0)
    team_games_per_season(team_id).each do |season, games|
      count = 0
      total = 0
      games.each do |game|
          if game.result == "WIN"
            count += 1
            total += 1
          else
            total += 1
          end
      win_count[season] = [count, total]
      end
    end
    win_count
  end

  def team_games_per_season(team_id)
    games_by_team = season_games.select {|team| team.team_id == team_id}
    team_games_per_season = games_by_team.group_by {|game| game.game_id[0..3]}
  end

  def season_games
    games_by_season.map {|season, games| games}.flatten.compact
  end

  def games_by_season
    games_by_season1 = {}
    game_ids_by_season.map do |season, game_ids|
      season_games = @game_teams.map do |game|
        if game_ids.include?(game.game_id)
          game
        end
      end
      games_by_season1[season] = season_games
    end
    games_by_season1
  end

  def game_ids_by_season
    game_ids_by_season = {}
    season_hash.map do |season, games|
      game_ids_by_season[season] = games.map {|game| game.game_id}
    end
    game_ids_by_season
  end

  def season_hash
    season_hash = @games.group_by {|games| games.season}
  end

  def games_by_team(team_id)
    select_teams(team_id, @game_teams)
  end

  def most_goals_scored(team_id)
    team_goals(team_id)
    most_goals = team_goals(team_id).max_by {|goals, game_team| goals}
    most_goals[0]
  end

  def fewest_goals_scored(team_id)
    games_by_team(team_id)
    team_goals(team_id)
    fewest_goals = team_goals(team_id).min_by {|goals, game_team| goals}
    fewest_goals[0]
  end

  def team_goals(team_id)
    team_goals = games_by_team(team_id).group_by do |game_team|
      game_team.goals
    end
    team_goals
  end

  def favorite_opponent(team_id)
    fav_opp = average_win_percentage_by_opponents_of(team_id).max_by do |opp_id, win_percent|
     win_percent
    end
    find_team_name(fav_opp.first)
  end

  def find_team_name(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end.teamname
  end

  def rival(team_id)
    not_fav_opp = average_win_percentage_by_opponents_of(team_id).min_by do |opp_id, win_percent|
      win_percent
    end
    find_team_name(not_fav_opp.first)
  end

  def average_win_percentage_by_opponents_of(team_id)
    average_opp_losses_against_our_team(team_id)
  end

  def games_won_by_team(team_id)
    games_won_against_opp_hash(team_id, @games)
  end

  def opponents_of(team_id)
    opponents_hash_count(team_id, @games)
  end
end
