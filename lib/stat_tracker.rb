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

  def lowest_scoring_visitor
    team_stats = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      if team_stats[row[:away_team_id]]
        team_stats[row[:away_team_id]][:total_away_goals] += row[:away_goals].to_i
        team_stats[row[:away_team_id]][:total_away_games] += 1
      else
        team_stats[row[:away_team_id]] = {total_away_games: 1, total_away_goals: row[:away_goals].to_i}
      end
    end

    lowest_scoring_away_team = team_stats.min_by do |team, stats|
      stats[:total_away_goals].to_f / stats[:total_away_games]
    end[0]

    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if lowest_scoring_away_team == row[:team_id]
    end
  end

  def lowest_scoring_home_team
    team_stats = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      if team_stats[row[:home_team_id]]
        team_stats[row[:home_team_id]][:total_home_goals] += row[:home_goals].to_i
        team_stats[row[:home_team_id]][:total_home_games] += 1
      else
        team_stats[row[:home_team_id]] = {total_home_games: 1, total_home_goals: row[:home_goals].to_i}
      end
    end

    lowest_scoring_home_team = team_stats.min_by do |team, stats|
      stats[:total_home_goals].to_f / stats[:total_home_games]
    end[0]

    CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
      return row[:teamname] if lowest_scoring_home_team == row[:team_id]
    end
  end

  def team_info(team_id)
    team_info = {}
    CSV.foreach(teams, headers: true, header_converters: :symbol) do |row|
      if row[:team_id] == team_id
        team_info[:team_id] = row[:team_id]
        team_info[:franchiseid] = row[:franchiseid]
        team_info[:teamname] = row[:teamname]
        team_info[:abbreviation] = row[:abbreviation]
        team_info[:link] = row[:link]
      end
    end
    team_info
  end

  # def team_id(team_name)
  #   CSV.foreach(teams, headers:true, header_converters: :symbol) do |row|
  #     return row[:team_id] if row[:teamname] == team_name
  #   end
  # end

  def best_season(team_id)
    seasons = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      if row[:home_team_id] == team_id
        if seasons[row[:season]]
          seasons[row[:season]][:total_games] += 1
          seasons[row[:season]][:total_home_wins] += 1 if row[:home_goals] > row[:away_goals]
        else
          seasons[row[:season]] = { total_games: 1, 
                                    total_home_wins: 1,
                                    total_away_wins: 0 }
            end
          end
        end
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      if row[:away_team_id] == team_id
        if seasons[row[:season]]
          seasons[row[:season]][:total_games] += 1
          seasons[row[:season]][:total_away_wins] += 1 if row[:away_goals] > row[:home_goals]
        else
          seasons[row[:season]] = { total_games: 1, 
                                    total_home_wins: 0,
                                    total_away_wins: 1 }
          end
        end
      end
      best_win_rate = seasons.max_by do |season, stats|
        ((stats[:total_home_wins] + stats[:total_away_wins]).to_f * 100 / stats[:total_games]).round(2)
      end
      best_win_rate[0]
  end

  def worst_season(team_id)
    seasons = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      if row[:home_team_id] == team_id
        if seasons[row[:season]]
          seasons[row[:season]][:total_games] += 1
          seasons[row[:season]][:total_home_wins] += 1 if row[:home_goals] > row[:away_goals]
        else
          seasons[row[:season]] = { total_games: 1, 
                                    total_home_wins: 1,
                                    total_away_wins: 0 }
            end
          end
        end
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      if row[:away_team_id] == team_id
        if seasons[row[:season]]
          seasons[row[:season]][:total_games] += 1
          seasons[row[:season]][:total_away_wins] += 1 if row[:away_goals] > row[:home_goals]
        else
          seasons[row[:season]] = { total_games: 1, 
                                    total_home_wins: 0,
                                    total_away_wins: 1 }
          end
        end
      end
      worst_win_rate = seasons.min_by do |season, stats|
        ((stats[:total_home_wins] + stats[:total_away_wins]).to_f * 100 / stats[:total_games]).round(2)
      end
      worst_win_rate[0]
  end
  
  def average_win_percentage(team_id)
    total_win = 0
    total_game = 0
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      if row[:team_id] == team_id
        if row[:result] == "WIN"
          total_win += 1
        end
        total_game += 1
      end
    end
    (total_win.to_f * 100 / total_game).round(2)
  end

  def most_goals_scored(team_id)
    most_goals = 0
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      if row[:team_id] == team_id
        most_goals = row[:goals].to_i if most_goals < row[:goals].to_i
      end
    end
    most_goals
  end
end

