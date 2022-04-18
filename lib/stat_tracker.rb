require 'csv'

require_relative 'game'
require_relative 'team'
require_relative 'game_team'
#


class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = read_games(locations[:games])
    @teams = read_teams(locations[:teams])
    @game_teams = read_game_teams(locations[:game_teams])
    # require 'pry'; binding.pry
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def read_games(csv)
  games_arr = []
    CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
      games_arr << Game.new(row)
    end
    games_arr
  end

  def read_teams(csv)
    teams_arr = []
    CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
      teams_arr << Team.new(row)
    end
    teams_arr
  end

  def read_game_teams(csv)
    game_teams_arr = []
    CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
      game_teams_arr << GameTeam.new(row)
    end
    game_teams_arr
  end

  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  def games_by_season(season)
    @games.select do |row|
      row.season == season
    end
  end

  def team_info(given_team_id)
    team = {}
    @teams.each do |row|
      if row.team_id == given_team_id
        team[:team_id] = row.team_id
        team[:franchise_id] = row.franchise_id
        team[:team_name] = row.team_name
        team[:abbreviation] = row.abbreviation
        team[:link] = row.link
      end
    end
    return team
  end

  def game_teams_by_season(season)
    @game_teams.select do |row|
      row.game_id.to_s[0..3] == season.to_s[0..3]
    end
  end

  def game_teams_by_team(team_id)
    @game_teams.select do |row|
      row.team_id == team_id
    end
  end

  def coaches_records(game_teams)
    hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
    game_teams.each do |row|
      if row.result == "WIN"
        hash[row.head_coach][0] += 1
      else
        hash[row.head_coach][1] += 1
      end
    end
    return hash
  end

  def win_tallies
    game_results = Hash.new({:home_wins => 0, :home_losses => 0, :away_wins => 0, :away_losses => 0, :home_ties => 0, :away_ties => 0})
      @game_teams.each do |game|
        if game.hoa == "home" && game.result == "WIN"
          game_results[:game_data][:home_wins] += 1
        elsif game.hoa == "home" && game.result == "LOSS"
          game_results[:game_data][:home_losses] += 1
        elsif game.hoa == "away" && game.result == "WIN"
          game_results[:game_data][:away_wins] += 1
        elsif game.hoa == "away" && game.result == "LOSS"
          game_results[:game_data][:away_losses] += 1
        elsif game.hoa == "home" && game.result == "TIE"
          game_results[:game_data][:home_ties] += 1
        elsif game.hoa == "away" && game.result == "TIE"
          game_results[:game_data][:away_ties] += 1
        end
      end
      game_results
  end

  def percentage_home_wins
    total_home_games = (win_tallies[:game_data][:home_wins] + win_tallies[:game_data][:home_losses] +
      win_tallies[:game_data][:home_ties])
    percentage_home_wins = (win_tallies[:game_data][:home_wins]/total_home_games.to_f).round(2)
  end

  def percentage_away_wins
    total_away_games = (win_tallies[:game_data][:away_wins] + win_tallies[:game_data][:away_losses] +
    win_tallies[:game_data][:away_ties])
    percentage_away_wins = (win_tallies[:game_data][:away_wins]/total_away_games.to_f).round(2)
  end

  def percentage_ties
    total_games = (win_tallies[:game_data][:home_wins] + win_tallies[:game_data][:home_losses] +
    win_tallies[:game_data][:away_wins] + win_tallies[:game_data][:away_losses] + win_tallies[:game_data][:home_ties] +
    win_tallies[:game_data][:away_ties])
    percentage_ties = ((win_tallies[:game_data][:home_ties] +
    win_tallies[:game_data][:away_ties])/total_games.to_f).round(2)
  end

  def seasons_unique
      seasons = @games.map { |game| game.season}.uniq
  end

  def count_games_by_season
    games_per_season = {}
    seasons_unique.each do |season|
      count = 0
      @games.each do |game|
        if season == game.season
          count += 1
          games_per_season[season.to_s] = count
        end
      end
    end
    games_per_season
  end

  def average_goals_by_season
    goals_by_season = Hash.new(0)
    seasons_unique.each do |season|
      count = 0
      @games.each do |game|
        if season == game.season
          count += 1
        end
      end

      @games.each do |game|
        if season == game.season
          goals_by_season[season.to_s] += game.away_goals + game.home_goals
        end
      end
      goals_by_season[season.to_s] = (goals_by_season[season.to_s]/count.to_f).round(2)
    end
    # require "pry"; binding.pry
    goals_by_season
  end

  def average_goals_per_game
    all_goals = 0.00
      @games.each do |game|
        all_goals += game.away_goals + game.home_goals
      end

    all_games = 0.00
      count_games_by_season.each do |k,v|
        all_games += v
      end

    average = (all_goals / all_games).round(2)
  end

  def win_percentage_by_coach(coaching_hash)
    coaching_hash.keys.map do |key|
      total_games = coaching_hash[key][0] + coaching_hash[key][1]
      coaching_hash[key][2] = coaching_hash[key][0]/total_games.to_f
    end
    return coaching_hash
  end

  def winningest_coach(season)
    season_game_teams = game_teams_by_season(season)
    coaches_hash = win_percentage_by_coach(coaches_records(season_game_teams))
    winning_coach = coaches_hash.max_by do |coach|
      coach[1][2]
    end[0]
  end

  def worst_coach(season)
    season_game_teams = game_teams_by_season(season)
    coaches_records = win_percentage_by_coach(coaches_records(season_game_teams))
    winning_coach = coaches_records.min_by do |coach|
      coach[1][2]
    end[0]
  end

  def team_name(id)
    @teams.find do |row|
      row.team_id == id
    end.team_name.to_s
  end

  def accuracy_hash(season)
    season_game_teams = game_teams_by_season(season)
    hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
    season_game_teams.each do |row|
      hash[row.team_id][0] += row.goals
      hash[row.team_id][1] += row.shots
      hash[row.team_id][2] = hash[row.team_id][0]/hash[row.team_id][1].to_f
    end
    hash
  end
  # require "pry"; binding.pry

  def most_accurate_team(season)
    accurate_team_id = accuracy_hash(season).max_by do |team|
      team[1][2]
    end[0]
    return team_name(accurate_team_id)
  end

  def least_accurate_team(season)
    accurate_team_id = accuracy_hash(season).min_by do |team|
      team[1][2]
    end[0]
    return team_name(accurate_team_id)
  end

  def tackle_hash(season)
    season_game_teams = game_teams_by_season(season)
    hash = Hash.new{|h,k| h[k] = 0 }
    season_game_teams.each do |row|
      hash[row.team_id] += row.tackles
    end
    hash
  end

  def most_tackles(season)
    most_tackles_team_id = tackle_hash(season).max_by do |team|
      team[1]
    end[0]
    return team_name(most_tackles_team_id)
  end

  def fewest_tackles(season)
    most_tackles_team_id = tackle_hash(season).min_by do |team|
      team[1]
    end[0]
    return team_name(most_tackles_team_id)
  end

  def count_of_teams
    @teams.count
  end

  def best_season(id)
    hash = win_percentage_by_team_id(id)
      season_id = hash.max_by do |season|
        season[1][2]
      end[0].to_i
      return  "#{season_id}#{season_id+1}"
  end

  def win_percentage_by_team_id(id)
    team_games = game_teams_by_team(id.to_i)
    hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
    # hash {wins => 0, games => 0, avg_win_pct => 0.to_f}
      team_games.each do |game|
        hash[game.game_id.to_s[0..3]][0]+=1
        if game.result == "WIN"
          hash[game.game_id.to_s[0..3]][1]+=1
          hash[game.game_id.to_s[0..3]][2] = hash[game.game_id.to_s[0..3]][1]/hash[game.game_id.to_s[0..3]][0].to_f
        end
      end
      hash
  end

  def worst_season(id)
      hash = win_percentage_by_team_id(id)
      season_id = hash.min_by do |season|
        season[1][2]
      end[0].to_i
      return  "#{season_id}#{season_id+1}"
  end

  def most_goals_scored(id)
    team_games = game_teams_by_team(id.to_i)
    team_games.map {|game| game.goals}.max
  end

  def fewest_goals_scored(id)
    team_games = game_teams_by_team(id.to_i)
    team_games.map {|game| game.goals}.min
  end

  def average_win_percentage(id)
    team_games = game_teams_by_team(id.to_i)
    win_total = 0
    game_total = 0
      team_games.each do |game|
        game_total += 1
        if game.result == "WIN"
          win_total += 1
        end
      end
    return (win_total/game_total.to_f).round(2)
  end

  def games_by_team(team_id)
    @games.select do |game|
      game.home_team_id == team_id.to_i || game.away_team_id == team_id.to_i
    end
  end

  def favorite_opponent(id)
    hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
    team_games = games_by_team(id)
    team_games.each do |game|
      if game.away_team_id == id.to_i
        hash[game.home_team_id][0]+=1
        if game.away_goals > game.home_goals
          hash[game.home_team_id][1]+=1
        end
      else
        hash[game.away_team_id][0]+=1
        if game.home_goals > game.away_goals
          hash[game.away_team_id][1]+=1
        end
      end
    end
    hash.keys.each do |key|
      hash[key][2] = hash[key][1]/hash[key][0].to_f
    end
    fav_opp_team_id = hash.max_by do |team|
      team[1][2]
    end[0]
    return team_name(fav_opp_team_id)
  end

  def rival(id)
    hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
    team_games = games_by_team(id)
    team_games.each do |game|
      if game.away_team_id == id.to_i
        hash[game.home_team_id][0]+=1
        if game.away_goals > game.home_goals
          hash[game.home_team_id][1]+=1
        end
      else
        hash[game.away_team_id][0]+=1
        if game.home_goals > game.away_goals
          hash[game.away_team_id][1]+=1
        end
      end
    end
    hash.keys.each do |key|
      hash[key][2] = hash[key][1]/hash[key][0].to_f
    end
    rival_id = hash.min_by do |team|
      team[1][2]
    end[0]
    return team_name(rival_id)
  end

  def avg_total_goals(team_id, hoa = nil)
    goals = []
    @game_teams.each do |game|
      if game.hoa == hoa or hoa == nil
        if game.team_id == team_id
          goals << game.goals.to_f
        end
      end
    end
    sum = goals.sum
    total_games = goals.length
    avg = (sum / total_games)
    avg.round(2)
  end

  def best_offense(hoa = nil)
   avg = []
   @teams.each do |team|
     avg << [team, avg_total_goals(team.team_id, hoa)]
   end
   high_avg_team = avg.max_by do |team|
     team[1]
   end[0].team_name
  end

  def worst_offense(hoa = nil)
   avg = []
   @teams.each do |team|
     avg << [team, avg_total_goals(team.team_id, hoa)]
   end
   low_avg_team = avg.min_by do |team|
     team[1]
   end[0].team_name
  end

  def highest_scoring_visitor
    best_offense("away")
  end

  def highest_scoring_home_team
    best_offense("home")
  end

  def lowest_scoring_visitor
    worst_offense("away")
  end

  def lowest_scoring_home_team
    worst_offense("home")
  end

end
