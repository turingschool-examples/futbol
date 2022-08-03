require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative './game_processor'
require_relative './league_processor'
require_relative './season_processor'

class StatTracker
  include GameProcessor
  include LeagueProcessor
  include SeasonProcessor

  attr_reader :locations, :data

  def initialize(game_path, team_path, game_teams_path)

    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path

  end

  def games
    games_csv = CSV.open(@game_path, headers: true, header_converters: :symbol)
    @games ||= games_csv.map do |row|
      Game.new(row)
    end
  end

  def teams
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    @teams ||= teams_csv.map do |row|
      Team.new(row)
    end
  end

  def game_teams
    game_teams_csv = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    @game_teams ||= game_teams_csv.map do |row|
      GameTeam.new(row)
    end
  end

  def self.from_csv(locations)
    StatTracker.new(
      locations[:games],
      locations[:teams],
      locations[:game_teams]
    )
  end

  def highest_total_score
    total_score('highest', games)
    # score_sum = 0
    # games.each do |game|
    #   if score_sum < game.total_goals_game
    #     score_sum = game.total_goals_game
    #   end
    # end
    # score_sum
  end

  def lowest_total_score
    total_score('lowest', games)
    # score_sum = Float::INFINITY
    # games.each do |game|
    #     if score_sum > game.total_goals_game
    #     score_sum = game.total_goals_game
    #   end
    # end
    # score_sum
  end

  def percentage_home_wins
    win_percentage('home', games)
    # total_games = 0.0
    # home_wins = 0.0
    # games.each do |game|
    #   total_games += 1
    #   if game.home_goals.to_i > game.away_goals.to_i
    #     home_wins += 1
    #   end
    # end
    # (home_wins / total_games).round(2)
  end

  def percentage_visitor_wins
    win_percentage('visitor', games)
    # total_games = 0.0
    # visitor_wins = 0.0
    # games.each do |game|
    #   total_games += 1
    #   if game.home_goals.to_i < game.away_goals.to_i
    #     visitor_wins += 1
    #   end
    # end
    # (visitor_wins / total_games).round(2)
  end

  def percentage_ties
    win_percentage('ties', games)
    # total_games = 0.0
    # ties = 0.0
    # games.each do |game|
    #   total_games += 1
    #   if game.home_goals.to_i == game.away_goals.to_i
    #     ties += 1
    #   end
    # end
    # (ties / total_games).round(2)
  end

  def count_of_games_by_season
    season_games = Hash.new(0)
    games.each do |game|
      season_games[game.season] += 1
    end
    season_games
  end

  def average_goals_per_game
    total_goals = 0.0
    games.each do |game|
      total_goals += game.total_goals_game
    end
    (total_goals / games.count).round(2)
  end

  def average_goals_by_season
    total_goals = total_goals_by_season(games)
    count = count_of_games_by_season
    avg_season_goals = Hash.new(0.0)
    total_goals.each do |season, goal|
      avg_season_goals[season] = (goal / count[season]).round(2)
    end
    avg_season_goals
  end

  def count_of_teams
    teams.count
  end

  def best_offense
    best_team_id = offense("best", game_teams)
    team_info(best_team_id.to_s)['team_name']
  end

  def worst_offense
    worst_team_id = offense("worst", game_teams)
    team_info(worst_team_id.to_s)['team_name']
  end

  def highest_scoring_visitor
    best_visitor_id = visitor_scoring_outcome("highest_scoring", games)
    team_info(best_visitor_id.to_s)['team_name']
  end

  def highest_scoring_home_team
    best_home_id = home_scoring_outcome("highest_scoring", games)
    team_info(best_home_id.to_s)['team_name']
  end

  def lowest_scoring_visitor
    worst_visitor_id = visitor_scoring_outcome("lowest_scoring", games)
    team_info(worst_visitor_id.to_s)['team_name']
  end

  def lowest_scoring_home_team
    worst_home_id = home_scoring_outcome("lowest_scoring", games)
    team_info(worst_home_id.to_s)['team_name']
  end

  def total_games_by_team(team_id)
    total_games = 0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      if row[:away_team_id] == team_id || row[:home_team_id] == team_id
        total_games += 1
      end
    end
    total_games
  end

  def winningest_coach(season_id)
    best_coach(coach_stats(season_id[0..3], game_teams))
  end

  def worst_coach(season_id)
    worstest_coach(coach_stats(season_id[0..3], game_teams))
  end

  def most_accurate_team(season_id)
    team_id = mostest_accurate_team(goal_stats(season_id[0..3], game_teams))
    team_info(team_id)["team_name"]
  end

  def least_accurate_team(season_id)
    team_id = leastest_accurate_team(goal_stats(season_id[0..3], game_teams))
    team_info(team_id)["team_name"]
  end

  def most_tackles(season_id)
    tackle_stats = tackle_stats(season_id[0..3], game_teams)
    team_info(tackle_stats.key(tackle_stats.values.max))["team_name"]
  end

  def fewest_tackles(season_id)
    tackle_stats = tackle_stats(season_id[0..3], game_teams)
    team_info(tackle_stats.key(tackle_stats.values.min))["team_name"]
  end

  def team_info(team_id)
    team_hash = Hash.new()
    teams.each do |team|
      if team.team_id == team_id
        team_hash['team_name'] = team.team_name
        team_hash['team_id'] = team.team_id
        team_hash['franchise_id'] = team.franchise_id
        team_hash['abbreviation'] = team.abbv
        team_hash['link'] = team.link
        return team_hash
      end
    end
  end

  def best_season(team_id)
    team_seasons = Hash.new { |season_id, games_won| season_id[games_won] = [0.0, 0.0] }
    game_teams.each do |game_team|
      if game_team.team_id == team_id
        team_seasons[game_team.game_id[0..3]][0] += 1
        if game_team.result == 'WIN'
          team_seasons[game_team.game_id[0..3]][1] += 1
        end
      end
    end
    highest_win_percentage = 0.0
    winningest_season = ''
    team_seasons.each do |season, wins_games|
      if highest_win_percentage < wins_games[1] / wins_games[0]
        highest_win_percentage = wins_games[1] / wins_games[0]
        winningest_season = season
      end
    end

    return "#{winningest_season}#{winningest_season.next}"
  end

  def worst_season(team_id)
    team_seasons = Hash.new { |season_id, games_won| season_id[games_won] = [0.0, 0.0] }
    game_teams.each do |game_team|
      if game_team.team_id == team_id
        team_seasons[game_team.game_id[0..3]][0] += 1
        if game_team.result == 'WIN'
          team_seasons[game_team.game_id[0..3]][1] += 1
        end
      end
    end
    lowest_win_percentage = 1.0
    losingest_season = ''
    team_seasons.each do |season, wins_games|
      if lowest_win_percentage > wins_games[1] / wins_games[0]
        lowest_win_percentage = wins_games[1] / wins_games[0]
        losingest_season = season
      end
    end
    # require 'pry'; binding.pry
    return "#{losingest_season}#{losingest_season.next}"
  end

  def average_win_percentage(team_id)
    games_played = 0.0
    games_won = 0.0
    game_teams.each do |game_team|
      if game_team.team_id == team_id
        games_played += 1
        if game_team.result == "WIN"
          games_won += 1
        end
      end
    end
    (games_won / games_played).round(2)
  end

  def most_goals_scored(team_id)
    highest_goal = 0
    game_teams.each do |game_team|
      if game_team.team_id == team_id
        if game_team.goals.to_i > highest_goal
          highest_goal = game_team.goals.to_i
        end
      end
    end
    highest_goal
  end

  def fewest_goals_scored(team_id)
    lowest_goal = 100000
    game_teams.each do |game_team|
      if game_team.team_id == team_id
        if game_team.goals.to_i < lowest_goal
          lowest_goal = game_team.goals.to_i
        end
      end
    end
    lowest_goal
  end

  def favorite_opponent(team_id)
    opponent_stats = Hash.new { |opponent_id, stats| opponent_id[stats] = [0.0, 0.0, 0.0] } #[games_played, games_won]
    games.each do |game|
      if game.home_team_id == team_id #|| row[:home_team_id] == team_id
        opponent_stats[game.away_team_id][0] += 1
        if game.home_goals > game.away_goals
          opponent_stats[game.away_team_id][1] += 1
        end
      end

      if game.away_team_id == team_id
        opponent_stats[game.home_team_id][0] += 1
        if game.away_goals > game.home_goals
          opponent_stats[game.home_team_id][1] += 1
        end
      end
    end

    highest_win_percentage = 0.0
    fav_opponent = ''
    opponent_stats.each do |opponent_id, stats|
      if highest_win_percentage < stats[1] / stats[0]
        highest_win_percentage = stats[1] / stats[0]
        fav_opponent = opponent_id
        stats[2] = stats[1] / stats[0] #not needed for this method. but might be useful for making team class?
      end
    end
    team_info(fav_opponent)['team_name']
  end

  def rival(team_id)
    opponent_stats = Hash.new { |opponent_id, stats| opponent_id[stats] = [0.0, 0.0, 0.0] } #[games_played, games_won]
    games.each do |game|
      if game.home_team_id == team_id #|| row[:home_team_id] == team_id
        opponent_stats[game.away_team_id][0] += 1
        if game.home_goals > game.away_goals
          opponent_stats[game.away_team_id][1] += 1
        end
      end

      if game.away_team_id == team_id
        opponent_stats[game.home_team_id][0] += 1
        if game.away_goals > game.home_goals
          opponent_stats[game.home_team_id][1] += 1
        end
      end
    end

    lowest_win_percentage = 1.0
    rival_id = ''
    opponent_stats.each do |opponent_id, stats|
      if lowest_win_percentage > stats[1] / stats[0]
        lowest_win_percentage = stats[1] / stats[0]
        rival_id = opponent_id
        stats[2] = stats[1] / stats[0] #not needed for this method. but might be useful for making team class?
      end
    end
    team_info(rival_id)['team_name']
  end
end
