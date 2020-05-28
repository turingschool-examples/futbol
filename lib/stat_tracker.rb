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
    GameCollection.new
  end

  def team_collection
    TeamCollection.new
  end

  def game_team_collection
    GameTeamCollection.new
  end

  def highest_total_score
    top_score = 0
    CSV.foreach(@games, headers: true, header_converters: :symbol) do |game|
      if game[:away_goals].to_i + game[:home_goals].to_i > top_score
        top_score = game[:away_goals].to_i + game[:home_goals].to_i
      end
    end
    top_score
  end

  def lowest_total_score
    lowest_score = 1_000_000_000
    CSV.foreach(@games, headers: true, header_converters: :symbol) do |game|
      if game[:away_goals].to_i + game[:home_goals].to_i < lowest_score
        lowest_score = game[:away_goals].to_i + game[:home_goals].to_i
      end
    end
    lowest_score
  end


##################### Beginning of League section #####################

  def count_of_teams

  end

  def best_offense

  end

  def worst_offense

  end

  def highest_scoring_visitor

  end

  def highest_scoring_home_team

  end

  def lowest_scoring_visitor

  end

  def lowest_scoring_home_team

  end

end 
