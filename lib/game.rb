class Game
  @@games = {}

  def self.add(game)
    @@games[game.game_id] = game
  end

  def self.all
    @@games
  end

  def self.games=(value)
    @@games = value
  end

  def self.find_all_scores(function = "add")
    total_scores = []
    Game.all.each_value do |value|
      if function == "subtract"
        total_scores << (value.home_goals - value.away_goals).abs
      else
        total_scores << value.home_goals + value.away_goals
      end
    end
    total_scores.uniq.sort
  end

  def self.games_outcome_percent(outcome = nil)
    games_count = 0.0
    Game.all.each_value do |value|
      if outcome == "away" && value.home_goals < value.away_goals
        games_count += 1
      elsif outcome == "home" && value.home_goals > value.away_goals
        games_count += 1
      elsif outcome == "draw" && value.home_goals == value.away_goals
        games_count += 1
      end
    end
    (games_count / Game.all.length).round(2)
  end

  def self.games_in_a_season(season)
    Game.all.select do |game_id, game|
      game.season == season
    end
  end

  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(data)
    @game_id = data[:game_id]
    @season = data[:season].to_s
    @type = data[:type]
    @date_time = data[:date_time]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @away_goals = data[:away_goals]
    @home_goals = data[:home_goals]
  end

end
