class StatTracker
  attr_reader :games, :game_teams, :teams
  def self.from_csv(locations)
    new(locations)
  end

  def initialize(locations)
    @games = locations[:games]
    @game_teams = locations[:game_teams]
    @teams = locations[:teams]
  end

  def highest_total_score # Rename later, for now from Games Table
    most = 0
    CSV.foreach(games, :headers => true, header_converters: :symbol) do |row|
      total = row[:away_goals].to_i + row[:home_goals].to_i
      most = total if total > most
    end
    most
  end

  def count_of_teams
    CSV.read(teams, headers: true).count
  end

  def best_offense
    team_stats = {}
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      if team_stats[row[:team_id]]
        team_stats[row[:team_id]][:total_goals] += row[:goals].to_i
        team_stats[row[:team_id]][:total_games] += 1
      else
        team_stats[row[:team_id]] = {total_games: 1, total_goals: row[:goals].to_i}
      end
    end

    top_offense_team = team_stats.max_by do |team, stats|
      stats[:total_goals].to_f / stats[:total_games]
    end[0]

    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if top_offense_team == row[:team_id]
    end
  end

  def worst_offense
    team_stats = {}
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      if team_stats[row[:team_id]]
        team_stats[row[:team_id]][:total_goals] += row[:goals].to_i
        team_stats[row[:team_id]][:total_games] += 1
      else
        team_stats[row[:team_id]] = {total_games: 1, total_goals: row[:goals].to_i}
      end
    end

    worst_offense_team = team_stats.min_by do |team, stats|
      stats[:total_goals].to_f / stats[:total_games]
    end[0]

    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if worst_offense_team == row[:team_id]
    end
  end

  def highest_scoring_visitor
    team_stats = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      if team_stats[row[:away_team_id]]
        team_stats[row[:away_team_id]][:total_away_goals] += row[:away_goals].to_i
        team_stats[row[:away_team_id]][:total_away_games] += 1
      else
        team_stats[row[:away_team_id]] = {total_away_games: 1, total_away_goals: row[:away_goals].to_i}
      end
    end

    highest_scoring_away_team = team_stats.max_by do |team, stats|
      stats[:total_away_goals].to_f / stats[:total_away_games]
    end[0]

    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if highest_scoring_away_team == row[:team_id]
    end
  end

  def highest_scoring_home_team
    team_stats = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      if team_stats[row[:home_team_id]]
        team_stats[row[:home_team_id]][:total_home_goals] += row[:home_goals].to_i
        team_stats[row[:home_team_id]][:total_home_games] += 1
      else
        team_stats[row[:home_team_id]] = {total_home_games: 1, total_home_goals: row[:home_goals].to_i}
      end
    end

    highest_scoring_home_team = team_stats.max_by do |team, stats|
      stats[:total_home_goals].to_f / stats[:total_home_games]
    end[0]

    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if highest_scoring_home_team == row[:team_id]
    end
  end

end
