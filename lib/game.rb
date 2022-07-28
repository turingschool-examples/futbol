class Game
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
    @game_id = data[:game_id].to_i
    @season = data[:season]
    @type = data[:type]
    @date_time = data[:date_time]
    @away_team_id = data[:away_team_id].to_i
    @home_team_id = data[:home_team_id].to_i
    @away_goals = data[:away_goals].to_i
    @home_goals = data[:home_goals].to_i
    @venue = data[:venue]
    @venue_link = data[:venue_link]
  end

  def self.highest_total_score(games)
    sorted_games = games.sort_by do |game|
      game.away_goals + game.home_goals
    end
    highest_scoring_game = sorted_games.reverse[0]
    highest_scoring_game.away_goals + highest_scoring_game.home_goals
  end

  def self.lowest_total_score(games)
    sorted_games = games.sort_by do |game|
      game.away_goals + game.home_goals
    end
    lowest_scoring_game = sorted_games[0]
    lowest_scoring_game.away_goals + lowest_scoring_game.home_goals
  end

  def self.percentage_home_wins(games)
    home_wins = games.select do |game|
      game if game.home_goals > game.away_goals
    end
    (home_wins.count.to_f / games.count * 100).round(2)
  end

  def self.percentage_away_wins(games)
    away_wins = games.select do |game|
      game if game.home_goals < game.away_goals
    end
    (away_wins.count.to_f / games.count * 100).round(2)
  end
end
