class SeasonStatistics
  attr_reader :locations,
              :teams_data,
              :game_data,
              :game_team_data
              
  def initialize(locations)
    @locations = locations
    @game_data = CSV.open locations[:games], headers: true, header_converters: :symbol
    @teams_data = CSV.open locations[:teams], headers: true, header_converters: :symbol
    @game_team_data = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
  end

  def winningest_coach(season_id)
    season_games = []

    @game_data.each do |row|
      if row[:season] == season_id
        season_games << row
      end
    end

    winning_games = Hash.new(0)
    games_played = Hash.new(0)

    season_games.each do |game|
      @game_team_data.each do |row|
        if row[:result] == "WIN"
          winning_games[row[:team_id]] += 1
          games_played[row[:team_id]] += 1
        elsif row[:result] == "LOSS"
          winning_games[row[:team_id]] = 0
          games_played[row[:team_id]] += 1
        end
      end
    end

    win_percentage = Hash.new(0)

    successful_team = winning_games.max_by do |team, games_won|
        (games_won/games_played[team] * 100).to_f
    end

    @game_team_data.rewind

    coach_name = ""
    
    @game_team_data.each do |row|
      coach_name = row[:head_coach] if row[:team_id] == successful_team[0]
    end

    coach_name
  end
end