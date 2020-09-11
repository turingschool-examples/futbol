require 'CSV'

class StatTracker
  attr_reader :game_manager,
              :game_teams_stats

  def initialize(locations)
    @game_manager = GameManager.new(locations[:games], self)
    @game_teams_stats = GameTeamsStats.new(locations[:game_teams], self)
    # @league_stats = LeagueStats.new()
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end



  def teams_stats
    teams_data = CSV.read(@teams, { encoding: 'UTF-8', headers: true, header_converters: :symbol, converters: :all })
    hashed_teams_data = teams_data.map { |row| row.to_hash }
    hashed_teams_data.each do |row|
      row.delete(:staduim)
    end
  end

  def highest_total_score
    @game_manager.highest_total_score
  end

  def lowest_total_score
    @game_manager.lowest_total_score
  end

  def percentage_home_wins
    @game_manager.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_manager.percentage_visitor_wins
  end

  def percentage_ties
    @game_manager.percentage_ties
  end

  def count_of_games_by_season
    @game_manager.count_of_games_by_season
  end

  def average_goals_per_game
    @game_manager.average_goals_per_game
  end

  def average_goals_by_season
    @game_manager.average_goals_by_season
  end

  def count_of_teams
    @league_stats.count_of_teams
  end

  def best_offense
    @league_stats.best_offense_stats
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense_stats
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    @league_stats.team_highest_away_goals
    @league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_stats.team_highest_home_goals
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_stats.team_lowest_away_goals
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.team_lowest_home_goals
    @league_stats.lowest_scoring_home_team
  end
end
