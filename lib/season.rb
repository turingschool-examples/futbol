class Season
  def initialize(game_team_data, game_data, team_data)
    @game_team_data = game_team_data
    @game_data = game_data
    @team_data = team_data
  end

  def coach_totals(season)
    coach_hash_total = Hash.new(0)
    @game_data.each do |game_row|
      if game_row[:season] == season
        season_game_id = game_row[:game_id]
        @game_team_data.each do |row|
          if row[:game_id] == season_game_id 
            head_coach = row[:head_coach]
            coach_hash_total[head_coach] += 1
          end
        end
      end
    end
    coach_hash_total
  end
  
  def coach_wins(season)
    coach_hash_winnings =  Hash.new(0)
    @game_data.each do |game_row|
      if game_row[:season] == season
        season_game_id = game_row[:game_id]
        @game_team_data.each do |row|
          if row[:game_id] == season_game_id && row[:result] == "WIN"
            head_coach = row[:head_coach]
            coach_hash_winnings[head_coach] += 1
          end
        end
      end
    end
    coach_hash_winnings
    require 'pry'; binding.pry
  end


  def winningest_coach(season)
    coach_win_percentage = Hash.new(0)

    coach_totals(season).each do |coach, total|
      win_count = coach_wins(season)[coach]
      percentage = (win_count.to_f / total.to_f) * 100
      coach_win_percentage[coach] = percentage
    end
    winningest_coach = coach_win_percentage.max_by { |coach, percentage| percentage }

    return winningest_coach[0]
  end

  def worst_coach(season)
    coach_win_percentage = Hash.new(0)

    coach_totals(season).each do |coach, total|
      win_count = coach_wins(season)[coach]
      percentage = (win_count.to_f / total.to_f) * 100
      coach_win_percentage[coach] = percentage
    end
    winningest_coach = coach_win_percentage.min_by { |coach, percentage| percentage }

    return winningest_coach[0]
  end
end

