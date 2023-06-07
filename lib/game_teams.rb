require 'csv'

class GameTeamsParser
  def self.parse(file_path)
    CSV.read(file_path, headers: true).map do |row|
      {
        game_id: row['game_id'],
        team_id: row['team_id'],
        hoa: row['HoA'],
        result: row['result'],
        settled_in: row['settled_in'],
        head_coach: row['head_coach'],
        goals: row['goals'].to_i,
        shots: row['shots'].to_i,
        tackles: row['tackles'].to_i,
        pim: row['pim'].to_i,
        power_play_opportunities: row['powerPlayOpportunities'].to_i,
        power_play_goals: row['powerPlayGoals'].to_i,
        face_off_win_percentage: row['faceOffWinPercentage'].to_f,
        giveaways: row['giveaways'].to_i,
        takeaways: row['takeaways'].to_i
      }
    end
  end
end
