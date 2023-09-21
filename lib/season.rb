class Season
  def initialize(game_team_data, game_data)
    @game_team_data = game_team_data
    @game_data = game_data
  end

  def winningest_coach(season)
    total_wins = 0
    total_games = 0

    coach_hash =  Hash.new(0)
    @game_data.each do |game_row|
      # require 'pry'; binding.pry
      game_row[:season] == season
      total_games += 1
      season_game_id = game_row[:game_id]
      @game_team_data.each do |row|
        if row[:game_id] == season_game_id && row[:result] == "WIN"
          head_coach = row[:head_coach]
          coach_hash[head_coach] += 1
        end
      end
    end
    coach_hash
    require 'pry'; binding.pry
  end
end