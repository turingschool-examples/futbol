class GameManager
  attr_reader :games, :tracker #do we need attr_reader?

  def initialize(path, tracker)
    @games = []
    @tracker = tracker
    create_games(path)
  end

  def create_games(path)
    games_data = CSV.read(path, headers:true) #may need to change .read to .load

    @games = games_data.map do |data|
      Game.new(data, self)
    end
  end

  #------------SeasonStats

  def games_of_season(season)
    @games.find_all {|game| game.season == season}
  end

  def find_game_ids_for_season(season)
    games_of_season(season).map {|game| game.game_id }
  end


#-------------GameStatistics

  def highest_total_score
    result = @games.max_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    result.away_goals.to_i + result.home_goals.to_i
  end

  def lowest_total_score
    result = @games.min_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
      result.away_goals.to_i + result.home_goals.to_i
  end

  def count_of_games_by_season
    games_by_season_index = {}
    games_by_season.each do |season, games|
      games_by_season_index[season] = games.length
    end
    games_by_season_index
  end

  def games_by_season
    result = {}
    games.each do |game|
      if result[game.season] == nil
        result[game.season] = [game]
      else
        result[game.season] << game
      end
    end
    result
  end

  def average_goals_per_game
    (total_goals.to_f / total_number_of_games).round(2)
  end

  def total_goals
    goal_count = 0
    games.each do |game|
      goal_count += game.home_goals.to_i
      goal_count += game.away_goals.to_i
    end
    return goal_count
  end

  def total_number_of_games
    game_count = 0
    games.each do |game|
      game_count += 1
    end
    return game_count
  end

  def average_goals_by_season
    season_hash = get_total_goals
    season_hash.each do |season, goals|
      count_of_games_by_season.each do |season_games, games|
        if season_games == season
          average = goals.to_f / games.to_f
          season_hash[season] = (average).round(2)
        end
      end
    end
  end

  def get_total_goals
    season_hash_with_goals = Hash.new
    season_hash_with_goals = games_by_season.each do |season, total_goals|
      @games.each do |game|
        if game.season == season
          total_goals += game.away_goals.to_i
          total_goals += game.home_goals.to_i
        end
      end
      season_hash_with_goals[season] = total_goals
    end
  end

  def games_by_season
    season_hash = Hash.new {|h,k| h[k] = 0}
    @games.each do |game|
      season_hash[game.season] = 0
    end
    season_hash
  end

end
