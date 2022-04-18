require './lib/futbol_csv_reader'

class GameChild < CSVReader

  def initialize(locations)
    super(locations)
  end

  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  def games_by_season(season)
    @games.select do |row|
      row.season == season
    end
  end

  def win_tallies
    game_results = Hash.new({:home_wins => 0, :home_losses => 0, :away_wins => 0, :away_losses => 0, :home_ties => 0, :away_ties => 0})
      @game_teams.each do |game|
        if game.hoa == "home" && game.result == "WIN"
          game_results[:game_data][:home_wins] += 1
        elsif game.hoa == "home" && game.result == "LOSS"
          game_results[:game_data][:home_losses] += 1
        elsif game.hoa == "away" && game.result == "WIN"
          game_results[:game_data][:away_wins] += 1
        elsif game.hoa == "away" && game.result == "LOSS"
          game_results[:game_data][:away_losses] += 1
        elsif game.hoa == "home" && game.result == "TIE"
          game_results[:game_data][:home_ties] += 1
        elsif game.hoa == "away" && game.result == "TIE"
          game_results[:game_data][:away_ties] += 1
        end
      end
      game_results
  end

  def percentage_home_wins
    total_home_games = (win_tallies[:game_data][:home_wins] + win_tallies[:game_data][:home_losses] +
      win_tallies[:game_data][:home_ties])
    percentage_home_wins = (win_tallies[:game_data][:home_wins]/total_home_games.to_f).round(2)
  end

  def percentage_away_wins
    total_away_games = (win_tallies[:game_data][:away_wins] + win_tallies[:game_data][:away_losses] +
    win_tallies[:game_data][:away_ties])
    percentage_away_wins = (win_tallies[:game_data][:away_wins]/total_away_games.to_f).round(2)
  end

  def percentage_ties
    total_games = (win_tallies[:game_data][:home_wins] + win_tallies[:game_data][:home_losses] +
    win_tallies[:game_data][:away_wins] + win_tallies[:game_data][:away_losses] + win_tallies[:game_data][:home_ties] +
    win_tallies[:game_data][:away_ties])
    percentage_ties = ((win_tallies[:game_data][:home_ties] +
    win_tallies[:game_data][:away_ties])/total_games.to_f).round(2)
  end

  def seasons_unique
      seasons = @games.map { |game| game.season}.uniq
  end

  def count_games_by_season
    games_per_season = {}
    seasons_unique.each do |season|
      count = 0
      @games.each do |game|
        if season == game.season
          count += 1
          games_per_season[season.to_s] = count
        end
      end
    end
    games_per_season
  end

  def average_goals_by_season
    goals_by_season = Hash.new(0)
    seasons_unique.each do |season|
      count = 0
      @games.each do |game|
        if season == game.season
          count += 1
        end
      end

      @games.each do |game|
        if season == game.season
          goals_by_season[season.to_s] += game.away_goals + game.home_goals
        end
      end
      goals_by_season[season.to_s] = (goals_by_season[season.to_s]/count.to_f).round(2)
    end
    # require "pry"; binding.pry
    goals_by_season
  end

  def average_goals_per_game
    all_goals = 0.00
      @games.each do |game|
        all_goals += game.away_goals + game.home_goals
      end

    all_games = 0.00
      count_games_by_season.each do |k,v|
        all_games += v
      end

    average = (all_goals / all_games).round(2)
  end
end
