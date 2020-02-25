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
      total_games += 1 if game.last.key?(team_id.to_i)
    end
    total_games
  end

  def all_game_teams_by_team_id(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    game_teams = GameTeam.all
    all_game_teams = []

    game_teams.each do |game|
      all_game_teams << game.last[team_id] if game.last.key?(team_id)
    end
    all_game_teams
  end

  def all_games_by_team_id(team_id)
    team_id = team_id.to_i if team_id.class != Integer
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
    team_id = team_id.to_i if team_id.class != Integer
    all_game_teams_by_team_id(team_id).map(&:result)
  end

  def average_win_percentage(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    total_games = total_number_games_by_team_id?(team_id).to_f
    return -0.0 if total_games.zero?

    total_wins = total_results_by_team_id(team_id).map do |game|
      game == "WIN" ? 1 : nil
    end.compact.sum

    (total_wins / total_games).round(2)
  end

  def all_goals_scored_by_team_id(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    all_game_teams_by_team_id(team_id).map do |game|
      game.goals
    end
  end

  def score_differences_by_team_id(team_id)
    team_id = team_id.to_i if team_id.class != Integer
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
    team_id = team_id.to_i if team_id.class != Integer
    Team.all[team_id].team_name
  end

  def win_percentage_by_season(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    games = all_games_by_team_id(team_id)
    season_results = {}
    total_games = 0.0

    games.each do |game|
      season = game.season.to_s
      unless season_results.key?(season)
        season_results[season] = Hash.new(0.0)
        season_results[season][:wins]
        season_results[season][:losses]
      end

      if team_id == game.home_team_id
        total_games += 1
        season_results[season][:wins] += 1 if game.away_goals < game.home_goals
        season_results[season][:losses] += 1 if game.home_goals < game.away_goals
      elsif team_id == game.away_team_id
        total_games += 1
        season_results[season][:wins] += 1 if game.home_goals < game.away_goals
        season_results[season][:losses] += 1 if game.away_goals < game.home_goals
      end
    end

    season_results.reduce({}) do |season_averages, (season, result)|
      season_averages[season] = (result[:wins] / total_games).round(3)
      season_averages
    end
  end

  def team_info(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    team = Team.all.fetch(team_id)
    team_info = {}
    team_info["team_id"] = team.team_id.to_s
    team_info["franchise_id"] = team.franchise_id.to_s
    team_info["team_name"] = team.team_name
    team_info["abbreviation"] = team.abbreviation
    team_info["link"] = team.link
    team_info
  end

  def best_season(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    season_averages = win_percentage_by_season(team_id)
    season_averages.max_by { |_season, result| result }.first
  end

  def worst_season(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    season_averages = win_percentage_by_season(team_id)
    season_averages.min_by { |_season, result| result }.first
  end

  def most_goals_scored(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    all_goals_scored_by_team_id(team_id).max
  end

  def fewest_goals_scored(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    return 0
    # all_goals_scored_by_team_id(team_id).min
  end

  def biggest_team_blowout(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    score_differences_by_team_id(team_id).max
  end

  def worst_loss(team_id)
    team_id = team_id.to_i if team_id.class != Integer
    score_differences_by_team_id(team_id).min.abs
  end
end
