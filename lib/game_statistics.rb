require 'csv'
class GameStatistics
  
  def highest_total_score
    highest_total_score = 0
  game_contents = CSV.open './fixture/games_fixture.csv', headers: true, header_converters: :symbol
  game_contents.each do |row|
    # game_id = row[:game_id]
    # season = row[:season]
    # type = row[:type]
    # date_time = row[:date_time]
    # away_team_id = row[:away_team_id]
    # home_team_id = row[:home_team_id]
    away_goals = row[:away_goals].to_i
    home_goals = row[:home_goals].to_i
    # venue = row[:venue]
    # venue_link= row[:venue_link]
    total_score = away_goals + home_goals
    if total_score > highest_total_score
      highest_total_score = total_score
    end
    # total_score.max_by |score| do
  end
  highest_total_score

  end


end