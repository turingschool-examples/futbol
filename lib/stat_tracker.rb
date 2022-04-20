require "csv"
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'game_team_stats'
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
    @game_team_stats = GameTeamStats.new(locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

# Game Statistics
  def highest_total_score
    highest_sum = 0
    @games.each do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
      highest_sum = sum if sum > highest_sum
    end
    highest_sum
  end

  def lowest_total_score
    lowest_sum = 0
    lowest = @games.map do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
    end
    lowest.min
  end

  def percentage_home_wins
    home_wins = []
    @game_teams.each do |game|
      if game.hoa == "home" && game.result == "WIN"
        home_wins << game
      end
     end
     (home_wins.length.to_f / @games.length.to_f).round(2)


  end

  def percentage_visitor_wins
    away_wins = []
    @game_teams.each do |game|
      if game.hoa == "away" && game.result == "WIN"
        away_wins << game
      end
     end
     (away_wins.length.to_f / @games.length.to_f).round(2)
     # require 'pry'; binding.pry
  end

  def percentage_ties
    # require 'pry'; binding.pry
    ((@game_teams.find_all { |game| game.result == 'TIE'}.count) / @game_teams.count.to_f).round(2)
  end 

  def count_of_games_by_season
    # require 'pry'; binding.pry
    @games.group_by {|game| game.season}.transform_values { |values| values.count}
  end

  def average_goals_per_game
    avg_goals = []
    @games.each do |game|
      goals = game.away_goals + game.home_goals
      avg_goals << goals
    end
    (avg_goals.sum.to_f / avg_goals.length).round(2)
  end

  def average_goals_by_season
    # season_goals = {}
    # season_goals = @games.group_by do |game|
    #   game.season
    # end
    # new_season_goals = season_goals.map do |season, games|
    #   games.map! do |game|
    #     game.away_goals + game.home_goals
    #   end.sum
      # require 'pry' ; binding.pry
    # end
    avg_goals_hash = {}
    avg = @games.group_by {|game| game.season}
    avg.map { |season, games| games.map!{ |game| game.away_goals + game.home_goals } }
    avg.map { |season, games| avg_goals_hash[season] = (games.sum / games.length.to_f).round(2) }
    avg_goals_hash
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

  def least_tackles(season_id)
    lowest_tackles = total_tackles_by_season(season_id).min_by do |team_id, total_tackles|
      total_tackles
    end
    team_name(lowest_tackles[0])
  end

  def games_by_season(season_id) # Take in an argument that is year/season converts game_id to year, returns :year{[games]}
    year = season_id[0..3]
    @game_teams.find_all do |game_team|
      game_team.game_id[0..3] == year
    end
  end

  def organize_teams(season_id) #organize by team_id returns :team_id{[games]}
    team_hash = games_by_season(season_id).group_by {|game| game.team_id}
  end

  def team_winning_percentage_by_season(season_id) #calculates/returns winning percentage
    win_percentage_hash = {}
    organize_teams(season_id).each do |team_id,game_teams|
      number_of_wins = 0
      game_teams.each do |game_team|
        if game_team.result == "WIN"
          number_of_wins += 1
        end
      end
        total_games = game_teams.count
        win_percentage = number_of_wins.to_f / total_games.to_f
        win_percentage_hash[team_id] = win_percentage.round(2)
      end
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

  # Team Statistics
  def team_info(team_id)
    @game_team_stats.team_info(team_id)
  end

  def season_games(game_id)
    @game_team_stats.season_games(game_id)
  end

  def best_season(team_id)
    @game_team_stats.best_season(team_id)
  end

  def worst_season(team_id)
    @game_team_stats.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @game_team_stats.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_team_stats.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_team_stats.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @game_team_stats.favorite_opponent(team_id)
  end

  def rival(team_id)
    @game_team_stats.rival(team_id)
  end
end
