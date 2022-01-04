class GameStatistics


games = CSV.open "data/games.csv", headers: true, header_converters: :symbol
  games.each do |row|
    @away_goals = row[:away_goals]
    @home_goals = row[:home_goals]
  end

  def highest_total_score

  end




end
