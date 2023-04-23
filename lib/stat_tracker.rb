require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'


class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data_hash)
    @games = data_hash[:games]
    @teams = data_hash[:teams]
    @game_teams = data_hash[:game_teams]
  end

  def self.from_csv(database_hash)
    data_hash = { :games => [], :teams => [], :game_teams => [] }

    if database_hash.keys.include?(:games)
      games = CSV.read(database_hash[:games], headers: true, header_converters: :symbol).each do |row|
        data_hash[:games] << Game.new(row)
      end
    end

    if database_hash.keys.include?(:teams)
      teams = CSV.read(database_hash[:teams], headers: true, header_converters: :symbol).each do |row|
        data_hash[:teams] << Team.new(row)
      end
    end

    if database_hash.keys.include?(:game_teams)
      game_teams = CSV.read(database_hash[:game_teams], headers: true, header_converters: :symbol).each do |row|
        data_hash[:game_teams] << GameTeams.new(row)
      end
    end
    new(data_hash)
  end

  def highest_total_score
      max_game = @games.max_by do |game|
        game.home_goals + game.away_goals
      end
      max_game.home_goals + max_game.away_goals
  end

  def average_goals_per_game
    goals = 0
    total_games = @games.count
    avg_goals = @games.each { |game| goals += game.away_goals + game.home_goals }
    (goals.to_f / total_games).round(2)
  end

  def average_goals_by_season
    season_name = @games.group_by {|game| game.season }.transform_values do |games|
      total_goals = games.sum { |game| game.away_goals + game.home_goals }
      (total_goals.to_f / games.count).round(2)
    end
  end

  def lowest_total_score
    min_game = @games.min_by do |game|
      game.home_goals + game.away_goals
    end
    min_game.home_goals + min_game.away_goals
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    season_name = @games.group_by {|game| game.season }
    season_name.map {|season_string, game| games_by_season[season_string] = game.count }
    games_by_season
  end
  
  def percentage_home_wins
    hoa = @game_teams.find_all {|gameteam| gameteam.hoa == "home" }
    results = hoa.select {|game| game.result == "WIN" }.count
    (results.to_f  / @games.count).round(2)
  end
  
  def percentage_visitor_wins
    hoa = @game_teams.find_all {|gameteam| gameteam.hoa == "away" }
    results = hoa.select {|game| game.result == "WIN" }.count
    (results.to_f  / @games.count).round(2)
  end
  
  def count_of_teams
    @teams.count
  end
  
  def best_offense
    average = averages_id_by_goals_games
    best = average.max_by do |id, ave|
      ave
    end
    best_name = @teams.select do |team|
      return team.teamname if best[0] == team.team_id
    end
  end
  
  def worst_offense
    average = averages_id_by_goals_games
    worst = average.min_by do |key, value|
      value
    end
    worst_name = @teams.select do |team|
      return team.teamname if worst[0] == team.team_id
    end
  end
  
  def lowest_scoring_home_team
    averages_id_by_goals_games
    low_team_id = averages_id_by_goals_games.min_by {|id, value| value }.first
    @teams.select { |team| team.team_id == low_team_id }.flat_map {|team| team.teamname }.join
  end

#helper method returns hash home/away team_id and total goals scored
  def total_goals
    team_goals = Hash.new(0)
    @games.each do |game|
      team_goals[game.home_team_id] = team_goals[game.home_team_id] + game.home_goals
      team_goals[game.away_team_id] = team_goals[game.away_team_id] + game.away_goals
    end
    team_goals
  end

#helper method returns hash home/away team_id and total games played
  def total_games
    team_games = Hash.new(0)
    @game_teams.each do |gameteam|
      team_games[gameteam.team_id] += 1
    end
    team_games
  end


  #helper method returns hash home/away team_id and average goals scored
  def averages_id_by_goals_games
    average = Hash.new(0)
    total_goals.each do |id, goals|
      total_games.each do |eye_d, games|
        if id == eye_d
          average[id] = goals/games.to_f
        end
      end
    end
    average
  end

  def winningest_coach(year)
    season_sort = @games.group_by { |game| game.season } 
    game_id_sort = @game_teams.group_by { |id| id.game_id }
 
    game_ids_season = Hash.new(0)
    @games.each { |game| game_ids_season[game.id] = game.season } 

    game_teams_ids = Hash.new(0)
    game_id_sort.each do |team, value|
      game_teams_ids[team] = [value[0].head_coach], [value[1].head_coach]
    end

    season_coaches = []
    game_ids_season.each do |id, season|
      game_teams_ids.each do |ids, coaches|
        if id == ids
          season_coaches << [season, coaches]
        end
      end
    end

    game_ids_wins = Hash.new(0)
    @game_teams.each do |team| 
      if team.result == "WIN"
        game_ids_wins[team.game_id] = team.head_coach
      end
    end

    season_game_id_hash = Hash.new(0)
    season_sort.each do |season, season_arr|
      season_game_id_hash[season] = []
      season_arr.each do |game|
        season_game_id_hash[season] << game.id
      end
    end

    coach_game_count = Hash.new(0)
    @game_teams.each do |coach|
      if !coach_game_count.keys.include?(coach.head_coach)
        coach_game_count[coach.head_coach] += 1
      else 
        coach_game_count[coach.head_coach] += 1
      end
    end

    wins = Hash.new(0)
    game_ids_wins.each do |key, value|
      coach_game_count.keys.each do |coach|
        if value == coach
          if wins.keys.include?(coach)
            wins[coach] += 1
          else
            wins[coach] += 1
          end
        end
      end
    end

    win_coach_hash = Hash.new(0)
    season_game_id_hash.each do |season, game_id_array|
      game_ids_wins.each do |game_id, winning_coach|
        win_coach_hash[winning_coach] += 1 if season == year && game_id_array.include?(game_id)
      end
    end

    coach_count_hash = Hash.new(0)
    season_game_id_hash.each do |season, game_id_array|
      game_teams_ids.each do |game_id, coaches|
        if game_id_array.include?(game_id) && season == year
          coaches.each do |coach|
            coach_count_hash[coach[0]] += 1 
          end
        end
      end
    end
    final_hash = Hash.new(0)
    win_coach_hash.each do |coach, wins|
      coach_count_hash.each do |coaches, games|
        final_hash[coach] = (wins/games.to_f).round(2) if coach == coaches
      end
    end
    high_avg = final_hash.max_by do |coach, average|
      average
    end
    high_avg[0]
  end

  

end