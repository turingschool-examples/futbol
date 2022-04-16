class Games
  attr_reader :game_id,
    :season,
    :type,
    :date_time,
    :away_team_id,
    :home_team_id,
    :away_goals,
    :home_goals,
    :venue,
    :venue_link

  def initialize(data)
    @game_id = data[:game_id]
    @season = data[:season]
    @type = data[:type]
    @date_time = data[:date_time]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @away_goals = data[:away_goals]
    @home_goals = data[:home_goals]
    @venue = data[:venue]
    @venue_link = data[:venue_link]
    @data = data
  end

  def total_scores
    @away_goals.each_with_index.map do |score, index|
      score.to_i + @home_goals[index].to_i
    end
  end

  def game_outcomes
    outcomes = Hash.new(0)
    @away_goals.each_with_index do |score, index|
      if score.to_i > @home_goals[index].to_i
        outcomes[:away_win] += 1
        outcomes[:total] += 1
      elsif score.to_i < @home_goals[index].to_i
        outcomes[:home_win] += 1
        outcomes[:total] += 1
      elsif score.to_i == @home_goals[index].to_i
        outcomes[:tie] += 1
        outcomes[:total] += 1
      else
        raise "error with game_outcomes"
      end
    end
    outcomes
  end

  def games_by_season_hash
    games_by_season = {count: Hash.new(0), average_goals: Hash.new(0)}
    # total_goals_by_season = {total_goals: Hash.new(0)}
    total_goals_by_season = Hash.new(0)
    @season.each_with_index do |season, index|
      games_by_season[:count][season] += 1
      total_goals_by_season[season] += (@data[:home_goals][index].to_i + @data[:away_goals][index].to_i)
      # total_goals_by_season[:total_goals][season] += (@data[:home_goals][index].to_i + @data[:away_goals][index].to_i)
    end
    games_by_season[:count].each do |season1, season_count|
      total_goals_by_season.each do |season2, total_score|
        games_by_season[:average_goals][season2] = (total_score.to_f / season_count.to_f).round(2) if
        season1 == season2
      end
    end
    games_by_season
  end
end
