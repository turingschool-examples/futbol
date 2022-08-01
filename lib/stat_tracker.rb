require_relative "./teams"
require_relative "./game"
require_relative "./game_teams"
require_relative "./game_stats"
require_relative "./teams_stats.rb"

class StatTracker
  attr_reader :game_stats,
              :teams,
              :game_teams

  def initialize(game_stats, teams_stats, game_teams)
    @game_stats = game_stats
    @teams_stats = teams_stats
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    game_stats = GameStats.from_csv(locations[:games])
    teams_stats = Teams.from_csv(locations[:teams])
    game_teams = GameTeams.create_multiple_game_teams(locations[:game_teams])
    StatTracker.new(game_stats, teams_stats, game_teams)
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    goals_by_season = Hash.new(0)
    @games.map do |game|
      goals_by_season[game.season] += ((game.home_goals.to_i + game.away_goals.to_i))
    end
    goals_by_season.each do |season, total|
      goals_by_season[season] = (total / (season_grouper[season].count).to_f).round(2)
    end
    goals_by_season
  end

  def count_of_teams
    @team_stats.count_of_teams
  end

  def best_offense
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each { |game_team| team_scores[game_team.team_id] << game_team.goals.to_f }

    team_scores_average =
      team_scores.map do |id, scores|
        [id, ((scores.sum) / (scores.length)).round(2)] #create an average out of the scores
      end
    team_id_to_name[maximum(team_scores_average)[0]]
  end

  def worst_offense
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each { |game_team| team_scores[game_team.team_id] << game_team.goals.to_f }

    team_scores_average =
      team_scores.map do |id, scores|
        [id, ((scores.sum) / (scores.length)).round(2)] #creat an average out of the scores
      end
    team_id_to_name[minimum(team_scores_average)[0]]
  end

  def highest_scoring_visitor
    away_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| away_team_scores[game.away_team_id] << game.away_goals.to_f }

    visitor_scores_average =
      away_team_scores.map do |id, scores|
        [id, ((scores.sum) / (scores.length)).round(2)] #create an average out of the scores
      end
    team_id_to_name[maximum(visitor_scores_average)[0]]
  end

  def most_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      goals_by_game << game.goals.to_i if team_id == game.team_id
    end
    goals_by_game.max
  end

  def fewest_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      goals_by_game << game.goals.to_i if team_id == game.team_id
    end
    goals_by_game.min
  end

  def average_win_percentage(team_id)
    total_games = team_isolator(team_id).count
    total_wins = win_isolator(team_id).count
    (total_wins.to_f / total_games).round(2)
  end

  def team_info(team_id)
    @team_stats.team_info(team_id)
  end

  def best_season(team_id) #we need a hash with each season as the keys and the win % for the season as the value
    games_by_season = team_season_grouper(team_id)  #hash with season as key and all the team's games for that season as the valueq
    win_percent_hash = Hash.new([])
    games_by_season.flat_map do |season, games|
      game_count = games.count
      home_wins = games.find_all { |game| (game.home_goals > game.away_goals) && team_id == game.home_team_id }.count
      away_wins = games.find_all { |game| (game.away_goals > game.home_goals) && team_id == game.away_team_id }.count
      win_percent = ((home_wins.to_f + away_wins.to_f) / game_count).round(2)
      win_percent_hash[season] = win_percent
    end
    ranked_seasons = win_percent_hash.max_by do |season, win_percent|
      win_percent
    end
    ranked_seasons[0]
  end

  def worst_season(team_id)
    games_by_season = team_season_grouper(team_id)  #hash with season as key and all the team's games for that season as the value
    win_percent_hash = Hash.new([])
    games_by_season.flat_map do |season, games|
      game_count = games.count
      home_wins = games.find_all { |game| (game.home_goals > game.away_goals) && team_id == game.home_team_id }.count
      away_wins = games.find_all { |game| (game.away_goals > game.home_goals) && team_id == game.away_team_id }.count
      win_percent = ((home_wins.to_f + away_wins.to_f) / game_count).round(2)
      win_percent_hash[season] = win_percent  #this is a hash with each season as the keys and the win % for the season as the value
    end
    ranked_seasons = win_percent_hash.min_by do |season, win_percent|
      win_percent
    end
    ranked_seasons[0]
  end

  def highest_scoring_home_team
    home_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| home_team_scores[game.home_team_id] << game.home_goals.to_f }

    home_scores_average =
      home_team_scores.map do |id, scores|
        average = ((scores.sum) / (scores.length)).round(2)
        [id, average]
      end
    team_id_to_name[maximum(home_scores_average)[0]]
  end

  def winningest_coach(season_id)
    game_id_list = []
    coaches = Hash.new(0)
    @games.each do |game|
      if game.season == season_id
        game_id_list << game.game_id
      end
    end

    @game_teams.each do |game_team|
      game_id = game_team.game_id
      coach = game_team.head_coach
      if !game_id_list.include? game_id
        next
      end

      if game_team.result == "WIN"
        coaches[coach] += 1
      end
    end

    coach_percentage_won =
      coaches.map do |coach_name, game_win|
        percentage_won = (game_win.to_f / game_id_list.length) * 100
        [coach_name, percentage_won]
      end.to_h
    maximum(coach_percentage_won)[0]
  end

  def worst_coach(season_id)
    coaches = {}
    game_id_list = []
    @games.each do |game|
      if game.season == season_id
        game_id_list << game.game_id
      end
    end
    coaches = Hash.new(0)

    @game_teams.each do |game_team|
      game_id = game_team.game_id
      coach = game_team.head_coach
      if !game_id_list.include? game_id
        next
      end
      if game_team.result == "LOSS"
        coaches[coach] += 1
      end
    end
    coach_percentage_lost = coaches.map do |coach_name, game_loss|
      percentage_lost = (game_loss.to_f / game_id_list.length) * 100
      [coach_name, percentage_lost]
    end.to_h
    minimum(coach_percentage_lost)[0]
  end

  def most_accurate_team(season_id)
    ratio = get_ratio(season_id)
    max_ratio = ratio.max_by { |k, v| v }[0]
    @teams.each do |team|
      team_id = team.team_id
      team_name = team.team_name

      if team_id == max_ratio
        return team_name
      end
    end
  end

  def least_accurate_team(season_id)
    ratio = get_ratio(season_id)
    min_ratio = ratio.min_by { |k, v| v }[0]
    @teams.each do |team|
      team_id = team.team_id
      team_name = team.team_name

      if team_id == min_ratio
        return team_name
      end
    end
  end

  def lowest_scoring_visitor
    away_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| away_team_scores[game.away_team_id] << game.away_goals.to_f }

    visitor_scores_average =
      away_team_scores.map do |id, scores|
        average = ((scores.sum) / (scores.length)).round(2)
        [id, average]
      end
    team_id_to_name[minimum(visitor_scores_average)[0]]
  end

  def lowest_scoring_home_team
    home_team_scores = Hash.new { |h, k| h[k] = [] }
    @games.each { |game| home_team_scores[game.home_team_id] << game.home_goals.to_f }

    home_scores_average =
      home_team_scores.map do |id, scores|
        average = ((scores.sum) / (scores.length)).round(2)
        [id, average]
      end
    team_id_to_name[minimum(home_scores_average)[0]]
  end

  def most_tackles(season)
    games_by_season = season_grouper[season] #season grouper is all games from the games csv grouped by season in arrays
    home_games = games_by_season.group_by { |game| game.home_team_id }

    away_games = games_by_season.group_by { |game| game.away_team_id }

    games_by_team_id =
      home_games.merge(away_games) { |team_id, home_game_array, away_game_array| home_game_array + away_game_array }
    #merged hash has 30 keys: each team's id. values are all games for a given season

    total_tackles = Hash.new(0)
    games_by_team_id.flat_map do |team_id, games|
      games.map do |game|
        tackles = number_of_tackles(team_id, game.game_id)
        total_tackles[team_id] += tackles
      end
    end
    team_id_to_name[maximum(total_tackles)[0]]
  end

  def fewest_tackles(season)
    games_by_season = season_grouper[season] #season grouper is all games from the games csv grouped by season in arrays
    home_games = games_by_season.group_by { |game| game.home_team_id }

    away_games = games_by_season.group_by { |game| game.away_team_id }

    games_by_team_id =
      home_games.merge(away_games) { |team_id, home_game_array, away_game_array| home_game_array + away_game_array }
    #merged hash has 30 keys: each team's id. values are all games for a given season

    total_tackles = Hash.new(0)
    games_by_team_id.flat_map do |team_id, games|
      games.map do |game|
        tackles = number_of_tackles(team_id, game.game_id)
        total_tackles[team_id] += tackles
      end
    end
    team_id_to_name[minimum(total_tackles)[0]]
  end

  def favorite_opponent(team_id)
    #{game=>{teams => [team1, team2], winning_team = team1}}
    game_hash = Hash.new { |h, k| h[k] = { is_our_team: false, other_team_id: nil, winning_team_id: nil } }

    @game_teams.each do |game|
      game_id = game.game_id
      winner = nil
      if game.result == "WIN"
        winner = game.team_id
      end
      if game.team_id == team_id
        game_hash[game_id][:is_our_team] = true
      else
        game_hash[game_id][:other_team_id] = game.team_id
      end
      if winner
        game_hash[game_id][:winning_team_id] = winner
      end
    end
    game_hash = game_hash
      .find_all { |game_id, teams_hash| teams_hash[:is_our_team] }
      .to_h

    team_scores = Hash.new { |h, k| h[k] = { wins: 0.0, losses: 0.0, ties: 0.0 } }
    game_hash.each do |game_id, teams_hash|
      other_team_id = teams_hash[:other_team_id]
      if teams_hash[:winning_team_id] == team_id
        team_scores[other_team_id][:losses] += 1
      elsif teams_hash[:winning_team_id] == other_team_id
        team_scores[other_team_id][:wins] += 1
      else
        team_scores[other_team_id][:ties] += 1
      end
    end

    min_win_percent =
      team_scores.min do |team_win_1, team_win_2|
        win_percentage_1 = (team_win_1[1][:wins] / (team_win_1[1][:losses] + team_win_1[1][:ties] + team_win_1[1][:wins])) * 100
        win_percentage_2 = (team_win_2[1][:wins] / (team_win_2[1][:losses] + team_win_2[1][:ties] + team_win_2[1][:wins])) * 100
        win_percentage_1 <=> win_percentage_2
      end
    min_win_team_id = min_win_percent[0]
    team_id_to_name[min_win_team_id]
  end

  def rival(team_id)
    game_hash = Hash.new { |h, k| h[k] = { is_our_team: false, other_team_id: nil, winning_team_id: nil } }

    @game_teams.each do |game|
      game_id = game.game_id
      winner = nil
      if game.result == "WIN"
        winner = game.team_id
      end
      if game.team_id == team_id
        game_hash[game_id][:is_our_team] = true
      else
        game_hash[game_id][:other_team_id] = game.team_id
      end
      if winner
        game_hash[game_id][:winning_team_id] = winner
      end
    end
    game_hash = game_hash
      .find_all { |game_id, teams_hash| teams_hash[:is_our_team] }
      .to_h

    team_scores = Hash.new { |h, k| h[k] = { wins: 0.0, losses: 0.0, ties: 0.0 } }
    game_hash.each do |game_id, teams_hash|
      other_team_id = teams_hash[:other_team_id]
      if teams_hash[:winning_team_id] == team_id
        team_scores[other_team_id][:losses] += 1
      elsif teams_hash[:winning_team_id] == other_team_id
        team_scores[other_team_id][:wins] += 1
      else
        team_scores[other_team_id][:ties] += 1
      end
    end

    max_win_percent =
      team_scores.max do |team_win_1, team_win_2|
        win_percentage_1 = (team_win_1[1][:wins] / (team_win_1[1][:losses] + team_win_1[1][:ties] + team_win_1[1][:wins])) * 100
        win_percentage_2 = (team_win_2[1][:wins] / (team_win_2[1][:losses] + team_win_2[1][:ties] + team_win_2[1][:wins])) * 100
        win_percentage_1 <=> win_percentage_2
      end
    max_win_team_id = max_win_percent[0]
    team_id_to_name[max_win_team_id]
  end
end
