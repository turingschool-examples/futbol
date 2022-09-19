require 'csv'
require 'pry'

class SeasonStatistics < StatTracker
    attr_reader :games, :teams, :team_games
    def initialize(games, teams, team_games)
        super(games, teams, team_games)
    end

  def self.from_csv(csv_hash)
    games_input = CSV.read(csv_hash[:games], headers: true, header_converters: :symbol)
    teams_input = CSV.read(csv_hash[:teams], headers: true, header_converters: :symbol)
    game_teams_input = CSV.read(csv_hash[:game_teams], headers: true, header_converters: :symbol)
    stats_tracker = TeamStatistics.new(games_input, teams_input, game_teams_input)
  end

  # Original method from Iteration 2
  def winningest_coach(season)
    coach_stats_by_season(season)
    @coaches_wins_to_losses.key(@coaches_wins_to_losses.values.max)
  end

   # Original method from Iteration 2
   def worst_coach(season)
    coach_stats_by_season(season)
    @coaches_wins_to_losses.key(@coaches_wins_to_losses.values.min)
  end

 # Original method from Iteration 2
 def most_accurate_team(season)
    shots_to_goals = season_shots_to_goals(season)
    most_accurate_team_id = (shots_to_goals.min_by {|team_id, ratio| ratio})[0]
    most_accurate_team = @teams.find do |team|
      team[:team_id] == most_accurate_team_id
    end
    most_accurate_team[:teamname]
  end

  # Original method from Iteration 2
  def least_accurate_team(season)
    shots_to_goals = season_shots_to_goals(season)
    least_accurate_team_id = (shots_to_goals.max_by {|team_id, ratio| ratio})[0]
    least_accurate_team = @teams.find do |team|
      team[:team_id] == least_accurate_team_id
    end
    least_accurate_team[:teamname]
  end

   # Original method from Iteration 2
   def most_tackles(season)
    tackles_by_team(season)
    team_with_most_tackles = @teams.find do |team|
      team[:team_id] == @tackles_counter.key(@tackles_counter.values.max)
    end
    team_with_most_tackles[:teamname]
  end

  # Original method from Iteration 2
  def fewest_tackles(season)
    tackles_by_team(season)
    team_with_least_tackles = @teams.find do |team|
      team[:team_id] == @tackles_counter.key(@tackles_counter.values.min)
    end
    team_with_least_tackles[:teamname]
  end
end
