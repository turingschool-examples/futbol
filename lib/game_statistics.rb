class Game
  def initialize(data)
    @data = data
    @total_away_wins = (@data.games.select {|row| row[:away_goals].to_i > row[:home_goals].to_i}).count
    @total_home_wins = (@data.games.select {|row| row[:home_goals].to_i > row[:away_goals].to_i}).count
    @total_games = @data.games.count
  end
  def lowest_total_score
    ordered_total_score(:lowest)
  end
  def highest_total_score
    ordered_total_score(:highest)
  end
  def ordered_total_score(option)
    sorted_games = (@data.games.map {|row| row[:away_goals].to_i + row[:home_goals].to_i}).sort.reverse
    if option == :highest
      sorted_games.shift
    elsif option == :lowest
      sorted_games.pop
    end
  end
  def percentage_home_wins
    (@total_home_wins.to_f / @total_games.to_f).round(2)
  end
  def percentage_visitor_wins
    (@total_away_wins.to_f / @total_games.to_f).round(2)
  end
end
