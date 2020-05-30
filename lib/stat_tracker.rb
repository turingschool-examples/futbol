class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]
  end

  def self.from_csv(data_files)
    StatTracker.new(data_files)
  end

  def game_collection
    GameCollection.new(@games)
  end

  def team_collection
    TeamCollection.new(@teams)
  end

  def game_team_collection
    GameTeamCollection.new(@game_teams)
  end

  def highest_total_score
    top_score = 0
    game_collection.all.each do |game|
      if game.away_goals.to_i + game.home_goals.to_i > top_score
        top_score = game.away_goals.to_i + game.home_goals.to_i
      end
    end
    top_score
  end

  def lowest_total_score
    lowest_score = 1000000
    game_collection.all.each do |game|
      if game.away_goals.to_i + game.home_goals.to_i < lowest_score
        lowest_score = game.away_goals.to_i + game.home_goals.to_i
      end
    end
    lowest_score
  end

  def home_games
    home_games = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa == "home"
        home_games << result
      end
    home_games.count(true)
  end

  def percentage_home_wins
    home_wins = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa == "home" && game_team.result == "WIN"
        home_wins << result
    end
    (home_wins.count(true) / home_games.to_f).round(2)
  end

  def visitor_games
    visitor_games = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa == "away"
      visitor_games << result
    end
    visitor_games.count(true)
  end

  def percentage_visitor_wins
    visitor_wins = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa == "away" && game_team.result == "WIN"
        visitor_wins << result
    end
    (visitor_wins.count(true) / visitor_games.to_f).round(2)
  end

  def all_games
    all_games = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa
      all_games << result
    end
    all_games.count
  end

  def percentage_ties
    ties = []
    game_team_collection.all.flat_map do |game_team|
      result =  game_team.result == "TIE"
        ties << result
    end
    (ties.count(true) / all_games.to_f).round(2)
  end

  def seasons
    seasons = []
    game_collection.all.flat_map do |game|
       seasons << game.season
    end
    seasons
  end

  def count_of_games_by_season
    games_per_season = Hash.new(0)
    seasons.each do |season|
       games_per_season[season] += 1
     end
     games_per_season
  end

  def sum_of_all_goals
    game_team_collection.all.sum do |game_team|
      game_team.goals.to_i
    end
  end

  def average_goals_per_game
    ((sum_of_all_goals / all_games.to_f) * 2).round(2)
  end

end
