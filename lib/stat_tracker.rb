require 'CSV'
require_relative 'game'
require_relative 'game_team'
require_relative 'team'
require_relative 'modules/accumulable'

class StatTracker
  include Accumulable

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

  def highest_total_score
      Game.find_all_scores.max
    end

  def lowest_total_score
    Game.find_all_scores.min
  end

  def biggest_blowout
    Game.find_all_scores("subtract").max
  end

  def percentage_home_wins
    Game.games_outcome_percent("home")
  end

  def percentage_visitor_wins
    Game.games_outcome_percent("away")
  end

  def percentage_ties
    Game.games_outcome_percent("draw")
  end

  def count_of_games_by_season
    Game.number_of_games_in_all_season
  end

  def average_goals_per_game
    (Game.total_goals_per_game / Game.number_of_games).round(2)
  end

  def average_goals_by_season
    Game.all_seasons.reduce({}) do |acc, season|
      games = Game.games_in_a_season(season)
      goals = Game.total_goals_per_game(games)
      acc[season] = (goals / games.length).round(2)
      acc
  end
  end

  def count_of_teams
    Team.all.count
  end

  def best_offense
    best_team = Team.all.values.max_by do |team|
      games_with_team = Game.games_played_by_team(team)
      if !games_with_team.empty?
        total_score = games_with_team.sum do |game|
          game.home_team_id == team.team_id ? game.home_goals : game.away_goals
        end
        total_score.to_f / games_with_team.count
      end
    end
    best_team.team_name
  end

  def worst_offense
    worst_team = Team.all.values.min_by do |team|
      games_with_team = Game.games_played_by_team(team)
      if !games_with_team.empty?
        total_score = games_with_team.sum do |game|
          game.home_team_id == team.team_id ? game.home_goals : game.away_goals
      end
        total_score.to_f / games_with_team.count
      end
    end
    worst_team.team_name
  end

  def best_defense
    best_team = Team.all.values.min_by do |team|
      games_with_team = Game.games_played_by_team(team)
      if !games_with_team.empty?
        total_score = games_with_team.sum do |game|
          game.home_team_id == team.team_id ? game.away_goals : game.home_goals
      end
        total_score.to_f / games_with_team.count
      end
    end
    best_team.team_name
  end

  def worst_defense
    worst_team = Team.all.values.max_by do |team|
      games_with_team = Game.games_played_by_team(team)
      if !games_with_team.empty?
        total_score = games_with_team.sum do |game|
          game.home_team_id == team.team_id ? game.away_goals : game.home_goals
      end
        total_score.to_f / games_with_team.count
      end
    end
    worst_team.team_name
  end

  def highest_scoring_visitor
    highest_visitor = Team.all.values.max_by do |team|
      games_visiting = Game.all.values.select { |game| game.away_team_id == team.team_id }
      total_score = games_visiting.sum { |game| game.away_goals }
      total_score.to_f / games_visiting.count
    end
    highest_visitor.team_name
  end

  def lowest_scoring_visitor
    highest_visitor = Team.all.values.min_by do |team|
      games_visiting = Game.all.values.select { |game| game.away_team_id == team.team_id }
      total_score = games_visiting.sum { |game| game.away_goals }
      total_score.to_f / games_visiting.count
    end
    highest_visitor.team_name
  end

  def highest_scoring_home_team
    highest_home = Team.all.values.max_by do |team|
      games_visiting = Game.all.values.select { |game| game.home_team_id == team.team_id }
      total_score = games_visiting.sum { |game| game.home_goals }
      total_score.to_f / games_visiting.count
    end
    highest_home.team_name
  end

  def lowest_scoring_home_team
    lowest_home = Team.all.values.min_by do |team|
      games_visiting = Game.all.values.select { |game| game.home_team_id == team.team_id }
      total_score = games_visiting.sum { |game| game.home_goals }
      total_score.to_f / games_visiting.count
    end
    lowest_home.team_name
  end

  def winningest_team
    winningest = Team.all.values.max_by do |team|
      games_with_team = Game.games_played_by_team(team)
      if !games_with_team.empty?
        games_won = games_with_team.count do |game|
          if game.home_team_id == team.team_id
            game.home_goals > game.away_goals
          else
            game.away_goals > game.home_goals
          end
        end
      end
      games_won.to_f / games_with_team.count
    end
    winningest.team_name
  end

  def best_fans
    biggest_home_away_diff = Team.all.values.max_by do |team|
      games_with_team = Game.games_played_by_team(team)
      if !games_with_team.empty?
        home_games, away_games = games_with_team.partition do |game|
          game.home_team_id == team.team_id
        end
        home_win_percentage = win_percentage(home_games, team)
        away_win_percentage = win_percentage(away_games, team)
        (home_win_percentage - away_win_percentage).abs
      end

    end
    biggest_home_away_diff.team_name
  end

  def worst_fans
    teams_with_better_away = Team.all.values.select do |team|
      games_with_team = Game.games_played_by_team(team)
      home_games, away_games = games_with_team.partition do |game|
        game.home_team_id == team.team_id
      end
      home_win_percentage = win_percentage(home_games, team)
      away_win_percentage = win_percentage(away_games, team)
      away_win_percentage > home_win_percentage
    end
    teams_with_better_away.map { |team| team.team_name }
  end

  def find_games(season, type)
    Game.all.select do |game_id, game_data|
      game_data.season == season && game_data.type == type
    end
  end

  def find_regular_season_teams(season)
    teams = []
    find_games(season, "Regular Season").select do |game_id, game_object|
        teams << game_object.home_team_id
        teams << game_object.away_team_id
    end
    teams = teams.uniq
  end

  def find_post_season_teams(season)
    teams = []
    find_games(season, "Postseason").select do |game_id, game_object|
      teams << game_object.home_team_id
      teams << game_object.away_team_id
    end
    teams = teams.uniq
  end

  def find_eligible_teams(season)
    eligible_teams = []
    find_regular_season_teams(season).each do |team_id|
      eligible_teams << team_id
    find_post_season_teams(season).each do |team_id|
      eligible_teams << team_id
      end
    end
    eligible_teams = eligible_teams.uniq
  end

  def win_percentage_by_season(season, team_id, type)
      team_games = find_games(season, type).select do |game_id, game_data|
        game_data.home_team_id == team_id || game_data.away_team_id == team_id
      end
      wins = 0
      team_games.each_value do |game_data|
        if team_id == game_data.home_team_id
          wins += 1 if game_data.home_goals > game_data.away_goals
        elsif team_id == game_data.away_team_id
          wins += 1 if game_data.away_goals > game_data.home_goals
        end
      end
      if team_games.count > 0
        percentage = wins.to_f/team_games.count
        percentage.round(3)
      elsif team_games.count == 0
        percentage = 0
      end
  end

  def post_season_decline(season)
    teams = {}
    find_eligible_teams(season).each do |team_id|
      teams[team_id] = win_percentage_by_season(season, team_id, "Regular Season") - win_percentage_by_season(season, team_id, "Postseason")
    end
    teams
  end

  def biggest_bust(season)
    maximum_decline_team = post_season_decline(season).max_by{|team, win_percentage| win_percentage}
    Team.all[maximum_decline_team[0]].team_name
  end

  def post_season_improvement(season)
    teams = {}
    find_eligible_teams(season).each do |team_id|
      teams[team_id] = win_percentage_by_season(season, team_id, "Postseason") - win_percentage_by_season(season, team_id, "Regular Season")
    end
    teams
  end

  def biggest_surprise(season)
    maximum_improvement = post_season_improvement(season).max_by {|team, win_percentage| win_percentage}
    Team.all[maximum_improvement[0]].team_name
  end

  def winningest_coach(season)
    season = season
    games = Game.games_in_a_season(season)
    coaches = coaches_with_team_id(games)
    winner = coaches.max_by do |coach, game_results|
      game_results.count("WIN") / game_results.count.to_f
    end
    winner.first
  end

  def gameteams_matching_games(games)
    GameTeam.all.select do |game_id, gameteam|
      games.keys.include?(game_id)
    end
  end

  def coaches_with_team_id(games)
    gamesteams = gameteams_matching_games(games)
    coaches = {}
    gamesteams.each_value do |gameteam|
      gameteam.each_value do |team|
        coaches[team.head_coach] = [] if !coaches.has_key?(team.head_coach)
        coaches[team.head_coach] << team.result
      end
    end
    coaches
  end

  def worst_coach(season)
    season = season
    games = Game.games_in_a_season(season)
    coaches = coaches_with_team_id(games)
    loser = coaches.min_by do |coach, game_results|
      game_results.count("WIN") / game_results.count.to_f
    end
    loser.first
  end

  def return_team_name(accumulator, condition = "max")
    if condition == "min"
      stat = accumulator.values.min
    else
      stat = accumulator.values.max
    end

    team = accumulator.key(stat)
    Team.all[team].team_name
  end

  def most_tackles(season)
    teams = game_team_info_by_season(season, "tackles")
    Team.return_team_name(teams.key(teams.values.max))
  end

  def fewest_tackles(season)
    teams = game_team_info_by_season(season, "tackles")
    Team.return_team_name(teams.key(teams.values.min))
  end

  def most_accurate_team(season)
    teams = game_team_info_by_season(season, "shots")
    accuracy = teams.transform_values { |team| team[:goals] / team[:shots].to_f }
    Team.return_team_name(accuracy.key(accuracy.values.max))
  end

  def least_accurate_team(season)
    teams = game_team_info_by_season(season, "shots")
    accuracy = teams.transform_values { |team| team[:goals] / team[:shots].to_f }
    Team.return_team_name(accuracy.key(accuracy.values.min))
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
      season_averages = win_percentage_by_season_by_team_id(team_id)
      season_averages.max_by { |_season, result| result }.first
    end

    def worst_season(team_id)
      team_id = team_id.to_i if team_id.class != Integer
      season_averages = win_percentage_by_season_by_team_id(team_id)
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

    def win_percentage(games, team)
      team = team.team_id if team.is_a?(Team)
      total_score = games.sum do |game|
        if game.home_team_id == team
          game.home_goals > game.away_goals ? 1 : 0
        elsif game.away_team_id == team
          game.away_goals > game.home_goals ? 1 : 0
        end
      end
      total_score.to_f / games.count
    end

    def win_percentage_against_opponent(team_id, opponent_team_id)
      team_id = team_id.to_i if team_id.class != Integer
      opponent_team_id = opponent_team_id.to_i if opponent_team_id.class != Integer
      games = all_games_by_team_id(team_id)
      total_opponent_wins = 0.0
      total_opponent_losses = 0.0
      total_games = 0.0

      games.each do |game|
        if opponent_team_id == game.away_team_id
          total_games += 1
          total_opponent_wins += 1 if game.home_goals < game.away_goals
          total_opponent_losses += 1 if game.away_goals < game.home_goals
        elsif opponent_team_id == game.home_team_id
          total_games += 1
          total_opponent_wins += 1 if game.away_goals < game.home_goals
          total_opponent_losses += 1 if game.home_goals < game.away_goals
        end
      end
      (total_opponent_wins / total_opponent_losses).round(3)
    end

    def all_team_average_wins_by_opponent(team_id)
      team_id = team_id.to_i if team_id.class != Integer
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

    def favorite_opponent(team_id)
      team_id = team_id.to_i if team_id.class != Integer
      team_averages = all_team_average_wins_by_opponent(team_id)
      rival = team_averages.min_by { |_team_id, result| result }.first
      get_team_name(rival)
    end

    def rival(team_id)
      team_id = team_id.to_i if team_id.class != Integer
      team_averages = all_team_average_wins_by_opponent(team_id)
      rival = team_averages.max_by { |_team_id, result| result }.first
      get_team_name(rival)
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

  def win_percentage_by_season_by_team_id(team_id)
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


end
