require_relative './findable.rb'

class League
  include Findable
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def count_of_teams
    @teams.count
  end

  def best_offense
    offense_avgs_by_team = Hash.new(0.0)
    total_goals_per_team.each do |team_id, total_goals|
      offense_avgs_by_team[team_id] = total_goals_per_team[team_id] / all_games_played(team_id).count
    end
    best_team_id = offense_avgs_by_team.key(offense_avgs_by_team.values.max)
    convert_team_id_to_name(best_team_id)
  end

  def worst_offense
    offense_avgs_by_team = Hash.new(0.0)
    total_goals_per_team.each do |team_id, total_goals|
      offense_avgs_by_team[team_id] = total_goals_per_team[team_id] / all_games_played(team_id).count
    end
    best_team_id = offense_avgs_by_team.key(offense_avgs_by_team.values.min)
    convert_team_id_to_name(best_team_id)
  end

  def games_by_team_id
    @game_teams.group_by {|game| game[:team_id]}
  end

  def collection_of_goals_per_team
    goals_per_team = Hash.new(0)
    games_by_team_id.each do |team_id, game_array|
      goals_per_team[team_id] = game_array.map {|game| game[:goals].to_f}
    end
    goals_per_team
  end

  def total_goals_per_team
    goal_grandtotals_per_team = Hash.new(0)
    collection_of_goals_per_team.each do |team_id, goals_array|
      goal_grandtotals_per_team[team_id] = goals_array.sum
    end
    goal_grandtotals_per_team
  end

  def all_games_played(team_id)
    find_in_sheet(team_id, :team_id, @game_teams)
  end

  def convert_team_id_to_name(team_id)
    team = find_in_sheet(team_id, :team_id, @teams)
    team[0][:teamname]
  end

  def highest_scoring_visitor
    score_ranker("high", "away")
  end

  def highest_scoring_home_team
    score_ranker("high", "home")
  end

  def lowest_scoring_visitor
    score_ranker("low", "away")
  end

  def lowest_scoring_home_team
    score_ranker("low", "home")
  end

  def score_ranker(rank, location)
    if rank == "high"
      team = avg_scoring(location).max_by { |k,v| v }
      team[0]
    elsif rank == "low"
      team = avg_scoring(location).min_by { |k,v| v }
      team[0]
    end
  end

  def avg_scoring(location)
    all_teams_data = {}
    all_team_ids = @teams.map {|row| row[:team_id]}
    all_team_ids.each do |id|
      goals = 0
      games_played = 0
      @games.each do |row|
        if row["#{location}_team_id".to_sym] == id
          goals += row["#{location}_goals".to_sym].to_i
          games_played += 1
        end
        all_teams_data[convert_team_id_to_name(id)] = (goals.to_f / games_played).round(2) unless games_played == 0
      end
    end
    all_teams_data
  end
end
