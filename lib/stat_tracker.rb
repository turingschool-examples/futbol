require "csv"
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_teams, :games_array

  def initialize(locations)
    @game_data = CSV.read(locations[:games], headers:true,
       header_converters: :symbol)
    @team_data = CSV.read(locations[:teams], headers:true,
       header_converters: :symbol)
    @game_team_data = CSV.read(locations[:game_teams],
       headers:true, header_converters: :symbol)
    # @games_array = []
    @games = Game.fill_game_array(@game_data)
    @teams = Team.fill_team_array(@team_data)
    @game_teams = GameTeams.fill_game_teams_array(@game_team_data)
    # binding.pry
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

# Game Statistics
  def highest_total_score
    highest_sum = 0
    @games.each do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
      #require 'pry'; binding.pry
      highest_sum = sum if sum > highest_sum
    end
    highest_sum
  end

# League Statistics
  def count_of_teams
    @teams.count
  end

  def best_offense
    team_hash = {}
    @game_teams.each do |game_team|
      if team_hash[game_team.team_id].nil?
        team_hash[game_team.team_id] = [game_team.goals]
      else
        team_hash[game_team.team_id] << game_team.goals
      end
    end
    sum_goals = 0
      team_hash.map do |team, goals|
        goals.each do |goal|
          sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
      end
      team_hash = team_hash.sort_by {|team_id, avg_goals| avg_goals}.reverse.to_h

      highest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals < highest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |team_id|
          team_names << team_name_helper(team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def worst_offense
    team_hash = {}
    @game_teams.each do |game_team|
      if team_hash[game_team.team_id].nil?
        team_hash[game_team.team_id] = [game_team.goals]
      else
        team_hash[game_team.team_id] << game_team.goals
      end
    end
    sum_goals = 0
      team_hash.map do |team, goals|
        goals.each do |goal|
          sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
      end
      team_hash = team_hash.sort_by {|team_id, avg_goals| avg_goals}.to_h

      lowest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals > lowest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |team_id|
          team_names << team_name_helper(team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def lowest_scoring_visitor
    team_hash = {}
    @games.each do |game|
      if team_hash[game.away_team_id].nil?
        team_hash[game.away_team_id] = [game.away_goals]
      else
        team_hash[game.away_team_id] << game.away_goals
      end
    end
    sum_goals = 0
      team_hash.map do |team, goals|
        goals.each do |goal|
          sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
      end
      team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.to_h

      lowest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals > lowest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
          team_names << team_name_helper(away_team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def highest_scoring_visitor
    team_hash = {}
    @games.each do |game|
      if team_hash[game.away_team_id].nil?
        team_hash[game.away_team_id] = [game.away_goals]
      else
        team_hash[game.away_team_id] << game.away_goals
      end
    end
    sum_goals = 0
      team_hash.map do |team, goals|
        goals.each do |goal|
          sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
      end
      team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.reverse.to_h

      highest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals < highest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
          team_names << team_name_helper(away_team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def highest_scoring_home_team
    team_hash = {}
    @games.each do |game|
      if team_hash[game.home_team_id].nil?
        team_hash[game.home_team_id] = [game.home_goals]
      else
        team_hash[game.home_team_id] << game.home_goals
      end
    end
    sum_goals = 0
      team_hash.map do |team, goals|
        goals.each do |goal|
          sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
      end
      team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.reverse.to_h

      highest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals < highest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
          team_names << team_name_helper(away_team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def lowest_scoring_home_team
    team_hash = {}
    @games.each do |game|
      if team_hash[game.home_team_id].nil?
        team_hash[game.home_team_id] = [game.home_goals]
      else
        team_hash[game.home_team_id] << game.home_goals
      end
    end
    sum_goals = 0
      team_hash.map do |team, goals|
        goals.each do |goal|
          sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
      end
      team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.to_h

      lowest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals > lowest_avg
      end

      if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
          team_names << team_name_helper(away_team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end
  end

  def team_name_helper(team_id)
    @teams.each do |team|
      if team.team_id == team_id
        return team.team_name
      end
    end
  end

  # Season Statistics

  ## Take in an argument that is year/season
  ##organize by team_id
  ##team_id.length, return total_games
  ##look at :result
  ##wins = +1, loss = 0, tie = 0, return win_total
  ##total wins / total games organize_teams["3"].length
  ##return percentage
  ##return a coach based on team_id
  #iterate through year/season to compare percentages
  #return highest percentage and coach

  def winningest_coach(season_id)
    best_team = team_winning_percentage_by_season(season_id).max_by do |team_id, percentage|
        percentage
      end
    head_coach_name(best_team[0])
  end

  def worst_coach(season_id)
    worst_team = team_winning_percentage_by_season(season_id).min_by do |team_id, percentage|
      percentage #look through my percentages
    end
    head_coach_name(worst_team[0])
  end

  def most_accurate_team(season_id)
    best_shot = team_shot_percentage_by_season(season_id).max_by do |team_id, percentage|
      percentage
    end
    team_name(best_shot[0])
  end

  def least_accurate_team(season_id)
    worst_shot = team_shot_percentage_by_season(season_id).min_by do |team_id, percentage|
      percentage
    end
    team_name(worst_shot[0])
  end

  def most_tackles(season_id)
    highest_tackles = total_tackles_by_season(season_id).max_by do |team_id, total_tackles|
      total_tackles
    end
    team_name(highest_tackles[0])
  end

  def fewest_tackles(season_id)
    lowest_tackles = total_tackles_by_season(season_id).min_by do |team_id, total_tackles|
      total_tackles
    end
    team_name(lowest_tackles[0])
  end

  def games_by_season # Take in an argument that is year/season converts game_id to year, returns :year{[games]}
    season_hash = @games.group_by {|game| game.season}
    games_by_season = {}
    season_hash.each do |season, games|
      games_by_season[season] = games.map do |game|
        game.game_id
      end
    end
    games_by_season
  end

  def stats_by_season
    stats = {}
    games_by_season.each do |season, games|
      @game_teams.each do |game_line|
        stats[season] = [] if stats[season].nil?
        stats[season] << game_line if games.include?(game_line.game_id)
      end
    end
    # binding.pry
    stats
  end

  # def organize_teams(season) #organize by team_id returns :team_id{[games]}
  #   binding.pry
  #   team_hash = stats_by_season.group_by {|game_team| @game_teams.team_id}
  # end

  def team_winning_percentage_by_season(season_id) #calculates/returns winning percentage
    win_percentage_hash = Hash.new(0)
      season = stats_by_season[season_id]
    season.each do |game_team|
        if game_team.result == "WIN"
          win_percentage_hash[game_team.team_id] += 1
        end
    total_games = season.count
    win_percentage = win_percentage_hash[game_team.team_id] /
        win_percentage_hash[game_team.team_id] = win_percentage.to_f.round(2)
      end
      binding.pry
      win_percentage_hash
  end

  def team_shot_percentage_by_season(season_id) #calculates/returns winning percentage
    shot_percentage_hash = {}
    organize_teams(season_id).each do |team_id,game_teams|
      number_of_goals = 0
      number_of_shots = 0
      game_teams.each do |game_team|
          number_of_goals += game_team.goals
          number_of_shots += game_team.shots
        end
        shot_percentage = number_of_goals.to_f / number_of_shots.to_f
        shot_percentage_hash[team_id] = shot_percentage.round(2)
      end
      shot_percentage_hash
  end

  def total_tackles_by_season(season_id)
    tackle_total_hash = {}
    organize_teams(season_id).each do |team_id,game_teams|
      number_of_tackles = 0
      game_teams.each do |game_team|
        number_of_tackles += game_team.tackles
      end
      tackle_total_hash[team_id] = number_of_tackles
    end
    tackle_total_hash
  end

  def head_coach_name(team_id) #return a coach based on team_id
    game_team_by_id = @game_teams.find do |game_team|
      game_team.team_id == team_id
    end
    game_team_by_id.head_coach
  end

  def team_name(team_id)
    team_name_by_id = @teams.find do |team|
      team.team_id == team_id
    end
    team_name_by_id.team_name
  end

end


  # Team Statistics
