class Games
  attr_reader :game_id,
              :season,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(locations)
    file = CSV.read locations[:games], headers: true, header_converters: :symbol
    @game_id = file[:game_id]
    @season = file[:season]
    @away_team_id = file[:away_team_id]
    @home_team_id = file[:home_team_id]
    @away_goals = file[:away_goals]
    @home_goals = file[:home_goals]
    @counter = 0
  end

  def highest_total_score
    calculate_highest_total_score
    @counter
  end
  
  def lowest_total_score
    min = 10
    (0..@game_id.length).each do |i|
      score = @home_goals[i].to_i + @away_goals[i].to_i
      min = [min, score].min
    end
    min
  end

  def average_goals_by_season
    avg_goals = Hash.new { |h, k| h[k] = Hash.new(0) }
    (0..@game_id.length).each do |i|
      season = @season[i]; goals = @home_goals[i].to_i + @away_goals[i].to_i
      avg_goals[season][:goals] += goals
      avg_goals[season][:games] += 1
    end

    avg_goals.delete(nil)

    avg_goals.transform_values do |season| 
      season[:goals].fdiv(season[:games]).round(2) 
    end
  end

  def percent_home_wins
    home_wins = 0
    (0..@game_id.length).each do |i|
      home_wins += 1 if @home_goals[i].to_i > @away_goals[i].to_i
    end
    home_wins.fdiv(@game_id.length).round(2)
  end

  def percent_away_wins
    away_wins = 0
    (0..@game_id.length).each do |i|
      away_wins += 1 if @home_goals[i].to_i < @away_goals[i].to_i
    end
    away_wins.fdiv(@game_id.length).round(2)
  end

  def percent_ties
    ties = 0
    (0..@game_id.length).each do |i|
      ties += 1 if @away_goals[i].to_i == @home_goals[i].to_i
    end
    ties.fdiv(@game_id.length).round(2)
  end

  def count_of_games_by_season
    season_games = Hash.new(0)
    (0..@game_id.length).each do |i|
      season = @season[i]
      season_games[season] += 1
    end
    season_games.delete(nil)
    season_games
  end

  def average_goals_per_game
    goals = 0
    (0..@game_id.length).each do |i|
      goals += @home_goals[i].to_i + @away_goals[i].to_i
    end
    goals.fdiv(@game_id.length).round(2)
  end


  # Helper Methods

  def calculate_highest_total_score
    @game_id.each_with_index do |_, i|
      total = @home_goals[i].to_i + @away_goals[i].to_i
      @counter = [@counter, total].max
    end
  end
end