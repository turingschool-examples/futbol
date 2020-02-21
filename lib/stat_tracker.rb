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

  def total_number_games_by_team_id(team_id) # HELPER METHOD
    games = GameTeam.all
    total_games = 0

    games.each do |game|
      total_games += 1 if game.last.key?(team_id)
    end
    total_games
  end

  def all_games_by_game_id(team_id) # Helper
    games = GameTeam.all

    all_games = []
    games.each do |game|
      all_games << game.last[team_id] if game.last.key?(team_id)
    end
    all_games
  end

  def total_results_by_team_id(team_id) # Unused Helper?
    all_games_by_game_id(team_id).map(&:result)
  end

  def average_win_percentage(team_id)
    games = GameTeam.all

    total_games = total_number_games_by_team_id(team_id).to_f
    return -0.0 if total_games == 0

    total_wins = all_games_by_game_id(team_id).map do |game|
      game.result == "WIN" ? 1 : nil
    end.compact.sum

    total_wins / total_games
  end

  def goals_scored(team_id)
    all_games_by_game_id(team_id).map do |game|
      game.goals
    end
  end

  def most_goals_scored(team_id)
    goals_scored(team_id).max
  end

  def fewest_goals_scored(team_id)
    return 0
    # goals_scored(team_id).min
  end

  # def rival(team_id)
  #   # average_win_percentage(team_id)
  #   rivals = Team.all.select { |team| team != team_id }

  #   test = rivals.reduce({}) do |rival_results, rival|
  #     rival_results[rival.last.team_id.to_s] = average_win_percentage(rival.last.team_id)
  #   end
  # end

  def score_differences_by_team_id(team_id)
    games = Game.all
    goal_differences = []

    games.each do |game|
      if game.last.home_team_id == team_id
        goal_differences << game.last.home_goals - game.last.away_goals
      else
        goal_differences << game.last.away_goals - game.last.home_goals
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
end
