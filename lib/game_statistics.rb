require 'csv'
class GameStatistics
  
  def highest_total_score
    highest_total_score = 0
    game_contents = CSV.open './fixture/games_fixture.csv', headers: true, header_converters: :symbol
    game_contents.each do |row|
    away_goals = row[:away_goals].to_i
    home_goals = row[:home_goals].to_i
    total_score = away_goals + home_goals
      if total_score > highest_total_score
        highest_total_score = total_score
      end
    end
    highest_total_score
  end

  def lowest_total_score
    lowest_total_score = nil
    game_contents = CSV.open './fixture/games_fixture.csv', headers: true, header_converters: :symbol
    game_contents.each do |row|
    away_goals = row[:away_goals].to_i
    home_goals = row[:home_goals].to_i
    total_score = away_goals + home_goals
      if lowest_total_score == nil || total_score < lowest_total_score
        lowest_total_score = total_score
      end
    end
    lowest_total_score
  end
  
  def percentage_home_wins  
    total_games = 0
    home_team_wins = 0
    game_contents = CSV.open './fixture/games_fixture.csv', headers: true, header_converters: :symbol
    game_contents.each do |row|
      away_goals = row[:away_goals].to_f
      home_goals = row[:home_goals].to_f
      total_games += 1.00
      if home_goals > away_goals
        home_team_wins += 1.00
      end
    end
    percentage_home_wins = home_team_wins / total_games
    percentage_home_wins.round(2)
  end


end