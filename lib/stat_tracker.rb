# Sum up Away and Home team's score per game_id
# Get data by col
  # Col by winning score + Col by losing score
# Parse CSV table initially and save as instance variable
# Method will iterate through instance variable
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

  def team_with_best_offense
    #Accumulating each team's total goals and game into a hash {total_games: x, total_goals: y}
    team_stats = {}
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      # Accumulates stats to existing stats
      if team_stats[row[:team_id]]
        team_stats[row[:team_id]][:total_goals] += row[:goals].to_i
        team_stats[row[:team_id]][:total_games] += 1
      else # Default value of team NOT YET in the team_stats hash{}
        team_stats[row[:team_id]] = {total_games: 1, total_goals: row[:goals].to_i}
      end
    end #End of accumulation

    #Find team with maximum goal average, returns game id
    top_offense_team = team_stats.max_by do |team, stats|
      stats[:total_goals].to_f / stats[:total_games]
    end[0] #End of finding top offense team

    #Find team name via team id
    CSV.foreach(teams, headers:true) do |row|
      return row["teamName"] if top_offense_team == row[:team_id]
    end
  end

  def team_with_worst_offense
    #Accumulating each team's total goals and game into a hash {total_games: x, total_goals: y}
    team_stats = {}
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      # Accumulates stats to existing stats
      if team_stats[row[:team_id]]
        team_stats[row[:team_id]][:total_goals] += row[:goals].to_i
        team_stats[row[:team_id]][:total_games] += 1
      else # Default value of team NOT YET in the team_stats hash{}
        team_stats[row[:team_id]] = {total_games: 1, total_goals: row[:goals].to_i}
      end
    end #End of accumulation

    #Find team with maximum goal average, returns game id
    worst_offense_team = team_stats.min_by do |team, stats|
      stats[:total_goals].to_f / stats[:total_games]
    end[0] #End of finding worst offense team

    #Find team name via team id
    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if worst_offense_team == row[:team_id]
    end
  end

  def highest_scoring_visitor
    # Team with highest avg score per game when they're away
    # Use games.csv to make a team stats {}
    # {away_team_id: away_goals}
    team_stats = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      # Accumulates stats to existing stats
      if team_stats[row[:away_team_id]]
        team_stats[row[:away_team_id]][:total_away_goals] += row[:away_goals].to_i
        team_stats[row[:away_team_id]][:total_away_games] += 1
      else # Default value of team NOT YET in the team_stats hash{}
        team_stats[row[:away_team_id]] = {total_away_games: 1, total_away_goals: row[:away_goals].to_i}
      end
    end #End of accumulation

    #Find team with maximum goal average, returns game id
    highest_scoring_away_team = team_stats.max_by do |team, stats|
      stats[:total_away_goals].to_f / stats[:total_away_games]
    end[0] #End of finding worst offense team

    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if highest_scoring_away_team == row[:team_id]
    end
  end

  def highest_scoring_home_team
    team_stats = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      # Accumulates stats to existing stats
      if team_stats[row[:home_team_id]]
        team_stats[row[:home_team_id]][:total_home_goals] += row[:home_goals].to_i
        team_stats[row[:home_team_id]][:total_home_games] += 1
      else # Default value of team NOT YET in the team_stats hash{}
        team_stats[row[:home_team_id]] = {total_home_games: 1, total_home_goals: row[:home_goals].to_i}
      end
    end #End of accumulation

    #Find team with maximum goal average, returns game id
    highest_scoring_home_team = team_stats.max_by do |team, stats|
      stats[:total_home_goals].to_f / stats[:total_home_games]
    end[0] #End of finding worst offense team

    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if highest_scoring_home_team == row[:team_id]
    end
  end

  def lowest_scoring_visitor
    team_stats = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      # Accumulates stats to existing stats
      if team_stats[row[:away_team_id]]
        team_stats[row[:away_team_id]][:total_away_goals] += row[:away_goals].to_i
        team_stats[row[:away_team_id]][:total_away_games] += 1
      else # Default value of team NOT YET in the team_stats hash{}
        team_stats[row[:away_team_id]] = {total_away_games: 1, total_away_goals: row[:away_goals].to_i}
      end
    end #End of accumulation

    #Find team with maximum goal average, returns game id
    lowest_scoring_away_team = team_stats.min_by do |team, stats|
      stats[:total_away_goals].to_f / stats[:total_away_games]
    end[0] #End of finding worst offense team

    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if lowest_scoring_away_team == row[:team_id]
    end
  end

  def lowest_scoring_home_team
    team_stats = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      # Accumulates stats to existing stats
      if team_stats[row[:home_team_id]]
        team_stats[row[:home_team_id]][:total_home_goals] += row[:home_goals].to_i
        team_stats[row[:home_team_id]][:total_home_games] += 1
      else # Default value of team NOT YET in the team_stats hash{}
        team_stats[row[:home_team_id]] = {total_home_games: 1, total_home_goals: row[:home_goals].to_i}
      end
    end #End of accumulation

    #Find team with maximum goal average, returns game id
    lowest_scoring_home_team = team_stats.min_by do |team, stats|
      stats[:total_home_goals].to_f / stats[:total_home_games]
    end[0] #End of finding worst offense team

    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if lowest_scoring_home_team == row[:team_id]
    end
  end

end
