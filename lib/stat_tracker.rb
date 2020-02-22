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

  # def best_season(team_id)
  #   games = GameTeam.all
  #   season_data = {}
  #   season_data[:total_games] = 0
  #   season_data[:total_wins] = 0

  #   games.each do |game|
  #     require 'pry'; binding.pry
  #     if game.last.key?(team_id)
  #       season_start = game.last[team_id].game_id.to_s.slice(0..3)
  #       season_end = game.last[team_id].game_id.to_s.slice(0..3).to_i + 1
  #       season_id = season_start + season_end.to_s
  #       season_data[season_id] =
  #     # game.game_id.to_s.slice(0..5)
  #     # season_data[ = 1 if game.last.key?(team_id)
  #     season_data[:total_games] += 1 if game.last.key?(team_id)
  #     season_data[:total_wins] += 1 if game.last[team_id] && game.last[team_id].result == "WIN"
  #   end
  # end

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

  def most_goals_scored(team_id)
    all_goals_scored_by_team_id(team_id).max
  end

  def fewest_goals_scored(team_id)
    return 0
    # all_goals_scored_by_team_id(team_id).min
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

  def biggest_team_blowout(team_id)
    score_differences_by_team_id(team_id).max
  end

  def worst_loss(team_id)
    score_differences_by_team_id(team_id).min.abs
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

  def rival(team_id)
    games = all_games_by_team_id(team_id)

    rivalries = games.reduce({}) do |rival_results, game|
      if game.home_team_id == team_id
        rival_results[game.away_team_id] = win_percentage_against_opponent(team_id, game.away_team_id)
      elsif game.away_team_id == team_id
        rival_results[game.home_team_id] = win_percentage_against_opponent(team_id, game.home_team_id)
      end
      rival_results
    end
    get_team_name(rivalries.max.first)
  end
end
