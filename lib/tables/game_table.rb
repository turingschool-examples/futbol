require_relative '../helper_modules/csv_to_hashable.rb'
require_relative '../instances/game'
class GameTable
  attr_reader :game_data, :stat_tracker
  include CsvToHash
  def initialize(locations)
    @game_data = from_csv(locations, 'Game')
    @stat_tracker = stat_tracker
  end

  def highest_total_score
    @game_data.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @game_data.map { |game| game.away_goals + game.home_goals}.min
  end

  def percentage_home_wins
    wins = 0
    total = @game_data.map { |game| wins += 1 if game.home_goals > game.away_goals }.count
    percentage = (wins.to_f / @game_data.count).round(2)
    percentage
    end

  def percentage_away_wins
    wins = 0
    total = @game_data.map { |game| wins += 1 if game.home_goals < game.away_goals }.count
    percentage = (wins.to_f / @game_data.count).round(2)
  end

  def percentage_ties
    wins = 0
    total = @game_data.map { |game| wins += 1 if game.home_goals == game.away_goals }.count
    percentage = (wins.to_f / @game_data.count).round(2)
  end

  def count_of_games_by_season
    s20122013 = []
      @game_data.find_all do |game|
        s20122013 << game.season if game.season.to_s.include?("20122013")
      end
    s20162017 = []
      @game_data.find_all do |game|
        s20162017 << game.season if game.season.to_s.include?("20162017")
      end
    s20142015 = []
      @game_data.find_all do |game|
        s20142015 << game.season if game.season.to_s.include?("20142015")
      end
    s20152016 = []
      @game_data.find_all do |game|
        s20152016 << game.season if game.season.to_s.include?("20152016")
      end
    s20132014 = []
      @game_data.find_all do |game|
        s20132014 << game.season if game.season.to_s.include?("20132014")
      end
    s20172018 = []
      @game_data.find_all do |game|
        s20172018 << game.season if game.season.to_s.include?("20172018")
      end
    result = {
      "20122013"=> s20122013.count,
      "20162017"=> s20162017.count,
      "20142015"=> s20142015.count,
      "20152016"=> s20152016.count,
      "20132014"=> s20132014.count,
      "20172018"=> s20172018.count
    }
  end

  def average_goals_by_season
    games_by_season_hash = @game_data.group_by {|game| game.season.to_s}
    goals = games_by_season_hash.each do |season, game|
      games_by_season_hash[season] = ((game.map {|indvidual_game| indvidual_game.away_goals.to_f + indvidual_game.home_goals.to_f}).sum/ game.count).round(2)

    end
    goals
  end

  def average_goals_per_game
    total_games = @game_data.count
    total_goals = @game_data.flat_map {|game| game.away_goals + game.home_goals}
    average = (total_goals.sum.to_f / total_games).round(2)
    average
  end

  def game_by_season
    season = @game_data.group_by do |game|
      game.season
    end
  end
  def favorite_opponent(results)
    team = results[1].to_i
    #finds all games played by team
    games = results[0].map{|result| @game_data.find_all{|game| game.game_id == result[0].to_i}}
    opp_data = games.map do |game|
      if game[0].away_team_id == team
        if game[0].away_goals - game[0].home_goals < 0
          [-1,game[0].home_team_id]
        else
          [1, game[0].home_team_id]
        end
      else
        if game[0].home_goals - game[0].away_goals < 0
          [-1, game[0].away_team_id]
        else
          [1, game[0].away_team_id]
        end
      end
    end
    hash = Hash.new
    opp_hash = opp_data.group_by{|opponent| opponent[1]}
    opp_data.group_by{|opponent| opponent[1]}.map{|opp|hash[opp[0]] = opp[1][0] }
    opp_hash.map{|opponent|hash[opponent[0]] = opponent[1].map{|item| item[0]}.sum.to_f / opponent[1].length}
    hash.max_by{|hash| hash[1]}[0]
  end

  def rival(results)
    team = results[1].to_i
    games = results[0].map{|result| @game_data.find_all{|game| game.game_id == result[0].to_i}}
    opp_data = games.map do |game|
      if game[0].away_team_id == team
        if game[0].away_goals - game[0].home_goals < 0
          [-1,game[0].home_team_id]
        else
          [1, game[0].home_team_id]
        end
      else
        if game[0].home_goals - game[0].away_goals < 0
          [-1, game[0].away_team_id]
        else
          [1, game[0].away_team_id]
        end
      end
    end
    hash = Hash.new
    opp_hash = opp_data.group_by{|opponent| opponent[1]}
    opp_data.group_by{|opponent| opponent[1]}.map{|opp|hash[opp[0]] = opp[1][0] }
    opp_hash.map{|opponent|hash[opponent[0]] = opponent[1].map{|item| item[0]}.sum.to_f / opponent[1].length}
    hash.min_by{|hash| hash[1]}[0]
  end
end
