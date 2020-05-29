class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]
  end

  def self.from_csv(data_files)
    StatTracker.new(data_files)
  end

  def game_collection
    GameCollection.new(@games)
  end

  def team_collection
    TeamCollection.new(@teams)
  end

  def game_team_collection
    GameTeamCollection.new(@game_teams)
  end

  def highest_total_score
    top_score = 0
    game_collection.all.each do |game|
      if game.away_goals + game.home_goals > top_score
        top_score = game.away_goals + game.home_goals
      end
    end
    top_score
  end

  def lowest_total_score
    lowest_score = 1000000
    game_collection.all.each do |game|
      if game.away_goals + game.home_goals < lowest_score
        lowest_score = game.away_goals + game.home_goals
      end
    end
    lowest_score
  end

end
