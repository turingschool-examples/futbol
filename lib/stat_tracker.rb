class StatTracker
  attr_reader :game_collection, :team_collection, :gtc
  def initialize(locations)
    @game_file_path = locations[:games]
    @teams_file_path = locations[:teams]
    @game_teams_file_path = locations[:game_teams]
    @gtc = nil
    @game_collection = nil
    @team_collection = nil
  end

  def load_game_team_data
    @gtc = GameTeamsCollection.new(@game_teams_file_path)
  end

  def load_game_data
    @game_collection = GameCollection.new(@game_file_path)
  end

  def load_team_data
    @team_collection = TeamCollection.new(@teams_file_path)
  end

  def highest_total_score
    game_collection.games.map do |game|
      game.home_goals + game.away_goals
    end.max
  end

  def biggest_blowout
    game_collection.games.map do |game|
      Math.sqrt((game.home_goals - game.away_goals)**2).to_i
    end.max
  end

  def percentage_ties
    ties = game_collection.games.find_all do |game|
      game.home_goals == game.away_goals
    end.length
    (ties / game_collection.games.length.to_f).round(2)
  end

  def count_of_games_by_season
    games_in_season = Hash.new(0)
    game_collection.games.each do |game|
        games_in_season[game.season] += 1
    end
    games_in_season
  end

end
