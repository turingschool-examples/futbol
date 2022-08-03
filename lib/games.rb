require './lib/details_loader'


class Games < DetailsLoader

  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
    @details = DetailsLoader.new(games, teams, game_teams)
  end

  def total_scores_by_game #helper for issue #2, #3, #6
    @games.values_at(:away_goals, :home_goals).map do |game|
      game[0] + game[1]
    end
  end

  def highest_total_score #issue #2
    total_scores_by_game.max
  end

  def lowest_total_score
    total_scores_by_game.min
  end

  def home_wins #create games_spec file to test this helper #helper for issue #4
  home_win = 0.0
  @game_teams.values_at(:result, :hoa).flat_map {|row| home_win += 1 if row == ["WIN", "home"]}; home_win
  end

  def home_games #helper for issue #4
    home = 0.0
    @game_teams[:hoa].map {|row| home += 1 if row == "home"}; home
  end

  def percentage_home_wins #issue #4 - Need to make this test eq 0.99 not whole numbers
    percentage = (home_wins/home_games).round(2)
  end

  def percentage_visitor_wins #issue #5 - passed spec harness and dummy

    away_wins = 0
    away_games_played = 0

    game_teams.each do |row|
      away_games_played += 1 if row[:hoa] == "away"
      away_wins += 1  if (row[:hoa] == "away" && row[:result] == "WIN")
    end
    (away_wins.to_f / away_games_played).round(2)
  end

  def percentage_ties #issue #6 - PASS
    ties = 0.0
    total_games = total_scores_by_game.count

    @games.values_at(:away_goals, :home_goals).each do |game|
      ties += 1 if game[0] == game[1]
    end
    (ties/total_games).round(1)
  end

    def count_of_games_by_season #issue 7, also helper for #9 - - season(key) out put nees to be string
    counts = {}
    games.each do |game|
        season = game[:season]
        if counts[season.to_s].nil?
             counts[season.to_s] = 0
        end
        counts[season.to_s] += 1
    end
    counts
  end

  def average_goals_per_game #issue #8 - Need to make this test eq 0.99 not whole numbers
    (total_scores_by_game.sum/@games.count.to_f).round(2)
  end

  def average_goals_by_season #issue #9 - Pass
  my_hash = Hash.new { |h,k| h[k] = [] }

    count_of_games_by_season.each do |season, game_count|
      my_hash[season] = []
      game_sum_calc = []
      games.each do |row|
        game_sum_calc << (row[:away_goals] + row[:home_goals]) if row[:season] == season.to_i
        #require 'pry';binding.pry
        my_hash[season] = (game_sum_calc.sum / game_count.to_f).round(2)
      end
    end
    my_hash
  end
end
