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

  def self.number_of_games
    @@games.length
  end

  def self.all_seasons
    seasons = @@games.values.reduce([]) do |acc, game|
      acc << game.season
    end
    seasons.uniq
  end

  def self.games_in_a_season(season)
    @@games.select do |_game_id, game|
      game.season == season
    end
  end

  def self.number_of_games_in_all_season
    @@games.values.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game.season.to_s] += 1
      games_by_season
    end
  end

  def self.total_goals_per_game(games = nil)
    if games != nil
      total_goals = games.values.sum { |game| game.total_goals }.to_f
    else
      total_goals = Game.all.sum { |_game_id, game| game.total_goals }.to_f
    end
  end

  def self.find_all_scores(function = "add")
    total_scores = Game.all.values.reduce([]) do |acc, value|
      if function == "subtract"
        acc << (value.home_goals - value.away_goals).abs
      else
        acc << value.home_goals + value.away_goals
      end
    end
    total_scores.uniq.sort
  end

  def self.games_outcome_percent(outcome = nil)
    games_count = 0.0
    Game.all.each_value do |value|
      away = (outcome == "away" && value.home_goals < value.away_goals)
      home = (outcome == "home" && value.home_goals > value.away_goals)
      draw = (outcome == "draw" && value.home_goals == value.away_goals)
      if away || home || draw
        games_count += 1
      end
    end
    (games_count / Game.number_of_games).round(2)
  end

  def self.games_played_by_team(team)
    Game.all.values.select do |game|
      game.home_team_id == team.team_id || game.away_team_id == team.team_id
    end
  end


  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :total_goals

  def initialize(data)
    @game_id = data[:game_id]
    @season = data[:season].to_s
    @type = data[:type]
    @date_time = data[:date_time]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @away_goals = data[:away_goals]
    @home_goals = data[:home_goals]
    @total_goals = @away_goals + @home_goals
  end

end
