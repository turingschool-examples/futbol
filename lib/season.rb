class Season
  def initialize(game_team_data, game_data)
    @game_team_data = game_team_data
    @game_data = game_data
  end

  def winningest_coach(season)
    coach_hash_total = Hash.new(0)
    coach_hash_winnings =  Hash.new(0)
    # total_games = 0
    @game_data.each do |game_row|
      if game_row[:season] == season
        # total_games += 1 #Total Games is only for ensuring that the season has been successfully isolated.
        season_game_id = game_row[:game_id]
        @game_team_data.each do |row|
          if row[:game_id] == season_game_id && row[:result] == "WIN"
            head_coach = row[:head_coach]
            coach_hash_winnings[head_coach] += 1
          end
          if row[:game_id] == season_game_id 
            head_coach = row[:head_coach]
            coach_hash_total[head_coach] += 1
          end
        end
      end
    end
    coach_win_percentage = Hash.new(0)

    coach_hash_total.each do |coach, total|
      win_count = coach_hash_winnings[coach]
      percentage = (win_count.to_f / total.to_f) * 100
      coach_win_percentage[coach] = percentage
    end
    winningest_coach = coach_win_percentage.max_by { |coach, percentage| percentage }

    return winningest_coach[0]
    # require 'pry'; binding.pry
  end
end

