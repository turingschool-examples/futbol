class StatTracker
  def initialize()
  end

  def self.from_csv(locations)
    StatTracker.create_items(locations[:games], Game)
    StatTracker.create_items(locations[:game_teams], GameTeam)
    StatTracker.create_items(locations[:teams], Team)
    StatTracker.new()
  end

  def self.create_items(file, item_class)
    csv_options = {
                    headers: true,
                    header_converters: :symbol,
                    converters: :all
                  }
      CSV.foreach(file, csv_options) { |row| item_class.add(item_class.new(row.to_hash)) }
  end

  def total_number_games_by_team_id?(team_id)
    games = GameTeam.all
    total_games = 0

    games.each do |game|
      total_games += 1 if game.last.key?(team_id)
    end
    total_games
  end

  def all_game_teams_by_team_id(team_id)
    game_teams = GameTeam.all
    all_game_teams = []

    game_teams.each do |game|
      all_game_teams << game.last[team_id] if game.last.key?(team_id)
    end
    all_game_teams
  end

  def all_games_by_team_id(team_id)
    games = Game.all
    all_games = []

    games.each do |game|
      if game.last.home_team_id == team_id || game.last.away_team_id == team_id
        all_games << game.last
      end
    end
    all_games
  end

  def total_results_by_team_id(team_id)
    all_game_teams_by_team_id(team_id).map(&:result)
  end

  def average_win_percentage(team_id)
    total_games = total_number_games_by_team_id?(team_id).to_f
    return -0.0 if total_games.zero?

    total_wins = total_results_by_team_id(team_id).map do |game|
      game == "WIN" ? 1 : nil
    end.compact.sum

    (total_wins / total_games).round(2)
  end

  def all_goals_scored_by_team_id(team_id)
    all_game_teams_by_team_id(team_id).map do |game|
      game.goals
    end
  end

  def score_differences_by_team_id(team_id)
    games = Game.all
    goal_differences = []

    games.each do |game|
      if game.last.home_team_id == team_id
        goal_differences << (game.last.home_goals - game.last.away_goals)
      elsif game.last.away_team_id == team_id
        goal_differences << (game.last.away_goals - game.last.home_goals)
      end
    end
    goal_differences
  end

  def get_team_name(team_id)
    Team.all[team_id].team_name
  end

  def win_percentage_against_opponent(team_id, opponent_team_id)
    games = all_games_by_team_id(team_id)
    total_losses = 0.0
    total_wins = 0.0

    games.each do |game|
      if opponent_team_id == game.home_team_id
        if game.home_goals > game.away_goals
          total_losses += 1
        elsif game.home_goals < game.away_goals
          total_wins += 1
        end
      elsif opponent_team_id == game.away_team_id
        if game.home_goals > game.away_goals
          total_wins += 1
        elsif game.home_goals < game.away_goals
          total_losses += 1
        end
      end
    end
    (total_wins / total_losses).round(2)
  end

  def win_percentage_by_season(team_id)
    games = all_games_by_team_id(team_id)
    season_results = {}

    games.each do |game|
      season = game.season.to_s
      season_results[season] = [0.0, 0.0] unless season_results.key?(season)

      if team_id == game.away_team_id
        season_results[season][0] += 1 if game.away_goals > game.home_goals
        season_results[season][1] += 1 if game.away_goals < game.home_goals
      elsif team_id == game.home_team_id
        season_results[season][0] += 1 if game.away_goals < game.home_goals
        season_results[season][1] += 1 if game.away_goals > game.home_goals
      end
    end

    season_results.reduce({}) do |season_averages, (season, result)|
      wins = result[0]
      losses = result[1]
      season_averages[season] = (wins / losses).round(2)
      season_averages
    end
  end

  def team_info(team_id)
    team = Team.all.fetch(team_id)
    team_info = {}
    team_info[:team_id] = team.team_id
    team_info[:franchiseid] = team.franchise_id
    team_info[:teamname] = team.team_name
    team_info[:abbreviation] = team.abbreviation
    team_info[:link] = team.link
    team_info
  end

  def best_season(team_id)
    season_averages = win_percentage_by_season(team_id)
    season_averages.max_by { |_season, result| result }.first
  end

  def worst_season(team_id)
    season_averages = win_percentage_by_season(team_id)
    season_averages.min_by { |_season, result| result }.first
  end

  def most_goals_scored(team_id)
    all_goals_scored_by_team_id(team_id).max
  end

  def fewest_goals_scored(team_id)
    return 0
    # all_goals_scored_by_team_id(team_id).min
  end

  def biggest_team_blowout(team_id)
    score_differences_by_team_id(team_id).max
  end

  def worst_loss(team_id)
    score_differences_by_team_id(team_id).min.abs
  end

  def all_team_average_wins_by_opponent(team_id)
    games = all_games_by_team_id(team_id)

    games.reduce({}) do |matchup_results, game|
      if game.home_team_id == team_id
        matchup_results[game.away_team_id] = win_percentage_against_opponent(team_id, game.away_team_id)
      elsif game.away_team_id == team_id
        matchup_results[game.home_team_id] = win_percentage_against_opponent(team_id, game.home_team_id)
      end
      matchup_results
    end
  end

  def rival(team_id)
    team_averages = all_team_average_wins_by_opponent(team_id)
    rival = team_averages.max_by { |_team_id, result| result }.first
    get_team_name(rival)
  end

  def favorite_opponent(team_id)
    team_averages = all_team_average_wins_by_opponent(team_id)
    rival = team_averages.min_by { |_team_id, result| result }.first
    get_team_name(rival)
  end

  def head_to_head(team_id)
    averages = all_team_average_wins_by_opponent(team_id)
    averages.reduce({}) do |results, (opponent_id, average)|
      results[get_team_name(opponent_id)] = average
      results
    end
  end

  def seasonal_win_percentage(team_id, season_type)
    games = all_games_by_team_id(team_id)
    total_wins = 0.0
    total_losses = 0.0

    season_type == :regular_season ? seasonal = "Regular Season" : seasonal = "Postseason"
    games.each do |game|
      next unless game.type == seasonal

      if team_id == game.home_team_id
        game.away_goals < game.home_goals ? total_wins += 1 : total_losses += 1
      elsif team_id == game.away_team_id
        game.home_goals < game.away_goals ? total_wins += 1 : total_losses += 1
      end
    end
    (total_wins / total_losses).round(2)
  end

  def seasonal_total_goals_scored(team_id, season_type)
    games = all_games_by_team_id(team_id)
    total_goals = 0

    season_type == :regular_season ? seasonal = "Regular Season" : seasonal = "Postseason"
    games.each do |game|
      next unless game.type == seasonal

      if team_id == game.home_team_id
        total_goals += game.home_goals
      elsif team_id == game.away_team_id
        total_goals += game.away_goals
      end
    end
    total_goals
  end

  def seasonal_total_goals_against(team_id, season_type)
    games = all_games_by_team_id(team_id)
    total_goals = 0

    season_type == :regular_season ? seasonal = "Regular Season" : seasonal = "Postseason"
    games.each do |game|
      next unless game.type == seasonal

      if team_id == game.home_team_id
        total_goals += game.away_goals
      elsif team_id == game.away_team_id
        total_goals += game.home_goals
      end
    end
    total_goals
  end

  def seasonal_average_goals_scored(team_id, season_type)
    games = all_games_by_team_id(team_id)
    season_type == :regular_season ? seasonal = "Regular Season" : seasonal = "Postseason"
    total_goals = seasonal_total_goals_scored(team_id, season_type)
    total_games = games.select { |game| game.type == seasonal }.length
    total_goals / total_games
  end

  def seasonal_average_goals_against(team_id, season_type)
    games = all_games_by_team_id(team_id)
    season_type == :regular_season ? seasonal = "Regular Season" : seasonal = "Postseason"
    total_goals = seasonal_total_goals_against(team_id, season_type)
    total_games = games.select { |game| game.type == seasonal }.length
    total_goals / total_games
  end

  def seasonal_summary(team_id)
    games = all_games_by_team_id(team_id)
    seasonal_summary = Hash.new({})

    games.each do |game|
      unless seasonal_summary.key?(game.season)
        seasonal_summary[game.season] = Hash.new({})

        seasonal_summary[game.season][:regular_season] = Hash.new({})
        seasonal_summary[:regular_season][:win_percentage] = seasonal_win_percentage(team_id, :regular_season)
        seasonal_summary[:regular_season][:total_goals_scored] = seasonal_total_goals_scored(team_id, :regular_season)
        seasonal_summary[:regular_season][:total_goals_against] = seasonal_total_goals_against(team_id, :regular_season)
        seasonal_summary[:regular_season][:average_goals_scored] = seasonal_average_goals_scored(team_id, :regular_season)
        seasonal_summary[:regular_season][:average_goals_against] = seasonal_average_goals_against(team_id, :regular_season)

        seasonal_summary[game.season][:postseason] = Hash.new({})
        seasonal_summary[:postseason][:win_percentage] = seasonal_win_percentage(team_id, :postseason)
        seasonal_summary[:postseason][:total_goals_scored] = seasonal_total_goals_scored(team_id, :postseason)
        seasonal_summary[:postseason][:total_goals_against] = seasonal_total_goals_against(team_id, :postseason)
        seasonal_summary[:postseason][:average_goals_scored] = seasonal_average_goals_scored(team_id, :postseason)
        seasonal_summary[:postseason][:average_goals_against] = seasonal_average_goals_against(team_id, :postseason)
      end
    end
    seasonal_summary
  end
end
