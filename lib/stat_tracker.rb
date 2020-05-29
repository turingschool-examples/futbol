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

  def all_games
    all_games = []
    game_team_collection.all.flat_map do |game_team|
      result = game_team.hoa
        all_games << result
      end
    all_games.count
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


end
