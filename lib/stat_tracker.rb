require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
  attr_reader :games, :teams, :game_teams, :seasons, :league

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(data)
    @games = game_init(data)
    @teams = teams_init(data)
    @game_teams = game_teams_init(data)
  end

  def game_init(data)
    CSV.read(data[:games], headers: true, header_converters: :symbol).map { |row| Game.new(row) }
  end

  def teams_init(data)
    CSV.read(data[:teams], headers: true, header_converters: :symbol).map { |row| Team.new(row) }
  end

  def game_teams_init(data)
    CSV.read(data[:game_teams], headers: true, header_converters: :symbol).map { |row| GameTeam.new(row) }
  end

  # GAME STATS

  def highest_total_score
    output = @games.max do |game1, game2|
      (game1.away_goals + game1.home_goals) <=> (game2.away_goals + game2.home_goals)
    end
    output.away_goals + output.home_goals
  end

  def home_win?
    @games.count { |game| game.home_goals > game.away_goals }
  end

  def percentage_home_wins
    (home_win?.to_f / @games.size).round(2)
  end

  def away_win?
    @games.count { |game| game.away_goals > game.home_goals }
  end

  def percentage_visitor_wins
    (away_win?.to_f / @games.size).round(2)
  end

  def total_goals_in_game
    @games.map do|game| 
      game.away_goals + game.home_goals
    end
  end

  def count_of_games_by_season
    games_by_season = {}
    @games.each do |game|
      if games_by_season.include?(game.season_id.to_sym)
        games_by_season[game.season_id.to_sym] += 1 
      else
        games_by_season[game.season_id.to_sym] = 1 
      end
    games_by_season
  end

  def count_of_goals_by_season
    goals_by_season = {}
    @games.each do |game|
      if goals_by_season.include?(game.season_id.to_sym)
        goals_by_season[game.season_id.to_sym] += ([game.away_goals.to_f]+[game.away_goals.to_f])
      elsif !goals_by_season.include?(game.season_id.to_sym)
        goals_by_season[game.season_id.to_sym] = ([game.away_goals.to_f]+[game.home_goals.to_f])
      end 
    goals_by_season
  end

  def average_goals_per_game
    (total_goals_in_game.sum / @games.count.to_f).round(2)
  end

  def average_goals_by_season
    average_goals = {}  
    count_of_goals_by_season.each do|season, goals|
      count_of_games_by_season.each do|season_id, games|
        if season_id == season
        average_goals[season_id] = (goals/games).round(2) 
    average_goals
  end

end


  # LEAGUE STATS

  def count_of_teams
    @teams.count
  end


  def team_goals(home_or_away)
    team_goals = {}
    @game_teams.each do |game_team|
      if team_goals[game_team.team_id.to_sym] != nil && game_team.home_or_away == home_or_away
        team_goals[game_team.team_id.to_sym].push(game_team.goals.to_i)
      elsif  game_team.home_or_away == home_or_away
        team_goals[game_team.team_id.to_sym] = [game_team.goals.to_i]
      end
    end
    team_goals
  end

  def average_goals(team_goals)
    team_average = {}
    team_goals.each do |team_id, goals_per_game|
      team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end
    team_average
  end

  def team_goal_average(home_or_away)
      team_goals = team_goals(home_or_away)
      average_goals(team_goals)
    end
  end

  def find_team_name(team_element)
    @teams.each do |team|
      if team_element[0] == team.team_id
        team_name = team.team_name
      end
    end
  end

  def highest_scoring_home_team
    highest_scoring = team_goal_average('home').max_by{ |team_id, average_goals| average_goals }
    find_team_name(highest_scoring)
  end


  def lowest_scoring_home_team
    lowest_scoring = team_goal_average('home').min_by{ |id, average| average }
  find_team_name(lowest_scoring)
  end

  # SEASON STATS
  def winningest_coach(season_id)
    season_games = @games.select { |game| game.season_id == season_id }
    season_game_ids = season_games.map(&:game_id)

    # Filter game_teams by season_game_ids
    season_game_teams = @game_teams.select { |game_team| season_game_ids.include?(game_team.game_id) }

    coach_wins = Hash.new(0)
    coach_games = Hash.new(0)

    season_game_teams.each do |game_team|
      coach_games[game_team.coach] += 1
      coach_wins[game_team.coach] += 1 if game_team.game_result == 'WIN'
    end

    win_percentages = coach_wins.each_with_object({}) do |(coach, wins), percentages|
      percentages[coach] = wins.to_f / coach_games[coach]
    end

    win_percentages.max_by { |_, percentage| percentage }.first
  end

  def worst_coach(season_id)
    season_games = @games.select { |game| game.season_id == season_id }
    season_game_ids = season_games.map(&:game_id)

    # Filter game_teams by season_game_ids
    season_game_teams = @game_teams.select { |game_team| season_game_ids.include?(game_team.game_id) }

    coach_wins = Hash.new(0)
    coach_games = Hash.new(0)

    season_game_teams.each do |game_team|
      coach_games[game_team.coach] += 1
      coach_wins[game_team.coach] += 1 if game_team.game_result == 'WIN'
    end

    worst_win_percentage = 1.0
    worst_coach = ''

    coach_games.each do |coach, games|
      win_percentage = coach_wins[coach].to_f / games
      if win_percentage < worst_win_percentage
        worst_win_percentage = win_percentage
        worst_coach = coach
      end
    end

    worst_coach
  end

  def lowest_total_score
    output = @games.min do |game1, game2|
      (game1.away_goals + game1.home_goals) <=> (game2.away_goals + game2.home_goals)
    end
    return output.away_goals + output.home_goals
  end


  def best_offense
    game_team_goals = {}
    @game_teams.each do |game_team|
      game_team_goals[game_team.team_id.to_sym] = []
      end
    @game_teams.each do |game_team|
      goal_array = game_team_goals[game_team.team_id.to_sym]
      goal_array << game_team.goals.to_i
    end
    game_team_goals.map do |team, goal_array|
      game_team_goals[team] = (goal_array.sum.to_f / goal_array.length.to_f)
    end

    best_avg = game_team_goals.max_by{ |team, goals| goals }

    team = @teams.find do |team|
    best_avg[0].to_s == team.team_id
    end
    team.team_name
  end

  def worst_offense
    game_team_goals = {}
    @game_teams.each do |game_team|
      game_team_goals[game_team.team_id.to_sym] = []
      end
    @game_teams.each do |game_team|
      goal_array = game_team_goals[game_team.team_id.to_sym]
      goal_array << game_team.goals.to_i
    end
    game_team_goals.map do |team, goal_array|
      game_team_goals[team] = (goal_array.sum.to_f / goal_array.length.to_f)
    end

    worst_avg = game_team_goals.min_by{ |team, goals| goals }

    team = @teams.find do |team|
    worst_avg[0].to_s == team.team_id
    end
    team.team_name
  end
  
  def most_tackles(season_id)
    season =  @games.find_all do |game|
      game.season_id == season_id
    end
    season_game_ids = season.map do |game|
      game.game_id
    end

    season_game_teams = []
    @game_teams.each do |game_team|
      if season_game_ids.include?(game_team.game_id)
        season_game_teams << game_team
      end
    end
    
    game_team_tackles = {}
    season_game_teams.each do |game_team|
      game_team_tackles[game_team.team_id.to_sym] = []
    end

    season_game_teams.each do |game_team|
      tackle_array = game_team_tackles[game_team.team_id.to_sym]
      tackle_array << game_team.tackles.to_i
    end

    game_team_tackles.map do |team, tackles_array|
      game_team_tackles[team] = tackles_array.sum
    end

    most = game_team_tackles.max_by{ |team, tackles| tackles }
    
    team = @teams.find do |team|
      most[0].to_s == team.team_id
    end
    team.team_name
  end




  def season_data(all_seasons)
    all_seasons = @games.map { |game| game[:season] }.uniq
    @season_data = {}
    season = []
    @game_teams.select do |game_team|      
      all_seasons.select do |season_id|
        if season_id[0,4] == game_team.game_id[0,4]
          season << game_team
          season_data[season_id[0,4].to_sym] = season
        end
      end
    end
    @season_data
  end

  def team_accuracy(season)
    season_goals = {}
    team_shots = {}

    game_team_season = @season_data[season.to_sym]
      season_goals[game_team_season.team_id.to_sym] += game_team_season.goals.to_i
      team_shots[game_team_season.team_id.to_sym] += game_team_season.shots.to_i
    end
    season_goals
    team_shots

    team_accuracy = {}

    team_accuracy.update(season_goals,team_shots) do |team,goals,shots|
      goals.fdiv(shots).round(4)*100
    end
    team_accuracy
  end


  def most_accurate_team(season)
    find_team_name(team_accuracy(season).max_by { |team_id,percent_accuracy| percent_accuracy })
  end
end


  def least_accurate_team(season)
    find_team_name(team_accuracy(season).min_by { |team_id,percent_accuracy| percent_accuracy })
  end
end
end












