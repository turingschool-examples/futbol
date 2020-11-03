require_relative './game'
require_relative './calculator'

class GamesCollection
  include Calculator

  attr_reader :games

  def initialize(file_path, parent)
    @parent = parent
    @games = create_games(file_path)
  end

  def create_games(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol).map do |row|
      Game.new(row)
    end
  end

  def find_season_id(id)
    game_ids = []
    games.find_all do |game|
      if game.season == id
        game_ids << game.game_id
      end
    end
    game_ids
  end

  def wins_by_hoa(hoa)
    games.count do |game|
      game.winner == hoa
    end
  end

  def seasons
    games.each_with_object(Hash.new(0)) do |game, seasons|
      seasons[game.season] += game.total_score
    end
  end

  def highest_total_score
    highest = @games.max_by do |game|
      game.total_score
    end
    highest.total_score
  end

  def lowest_total_score
    lowest = @games.min_by do |game|
      game.total_score
    end
    lowest.total_score
  end

  def percentage_home_wins
    (wins_by_hoa("home").to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    (wins_by_hoa("away").to_f / @games.length).round(2)
  end

  def percentage_ties
    (wins_by_hoa("tie").to_f / @games.length).round(2)
  end

  def count_of_games_by_season
    seasons = Hash.new(0)
    games.each do |game|
      seasons[game.season] += 1
    end
    seasons
  end

  def average_goals_per_game
    total_goals = games.sum do |game|
      game.total_score
    end
    (total_goals.to_f / games.count).round(2)
  end

  def average_goals_by_season
    combine(count_of_games_by_season, seasons)
  end

  def team_wins_by_season(team_id)
    @games.each_with_object(Hash.new {|h, k| h[k] = {success: 0, total: 0}}) do |game, wins|
      next if !game.teams.include?(team_id)
      wins[game.season][:total] += 1
      wins[game.season][:success] += 1 if game.won_game?(team_id)
    end
  end

  def goals_scored_by_team(team_id)
    games_with_goals = Hash.new(0)
    @games.each do |game|
      if game.away_team_id == team_id
        games_with_goals[game.game_id] = game.away_goals
      elsif game.home_team_id == team_id
        games_with_goals[game.game_id] = game.home_goals
      end
    end
    games_with_goals
  end

  def team_wins_by_opponent(team_id)
    @games.each_with_object(Hash.new {|h, k| h[k] = {success: 0, total: 0}}) do |game, wins|
      next if !game.teams.include?(team_id)
      wins[game.opponent(team_id)][:total] += 1
      wins[game.opponent(team_id)][:success] += 1 if game.won_game?(team_id)
    end
  end

  def best_season(team_id)
    max_avg(team_wins_by_season(team_id)).first
  end

  def worst_season(team_id)
    min_avg(team_wins_by_season(team_id)).first
  end

  def average_win_percentage(team_id)
    win_pct(team_wins_by_season(team_id))
  end

  def most_goals_scored(team_id)
    high(goals_scored_by_team(team_id)).last
  end

  def fewest_goals_scored(team_id)
    low(goals_scored_by_team(team_id)).last
  end

  def favorite_opponent(team_id)
    max_avg(team_wins_by_opponent(team_id)).first
  end

  def rival(team_id)
    min_avg(team_wins_by_opponent(team_id)).first
  end
end
