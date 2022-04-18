require 'csv'

# game_data = CSV.open"./data/games.csv", headers: true, header_converters: :symbol

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
      @teams.map {|team| team.team_id}.length
  end

  def best_season(id)
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
      season_id = hash.max_by do |season|
        season[1][2]
      end[0].to_i
      # require "pry"; binding.pry
      return  "#{season_id}#{season_id+1}"
  end

  def worst_season(id)
    team_games = game_teams_by_team(id.to_i)
    hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
      team_games.each do |game|
        hash[game.game_id.to_s[0..3]][0]+=1
        if game.result == "WIN"
          hash[game.game_id.to_s[0..3]][1]+=1
          hash[game.game_id.to_s[0..3]][2] = hash[game.game_id.to_s[0..3]][1]/hash[game.game_id.to_s[0..3]][0].to_f
        end
      end
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
    # hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
      team_games.each do |game|
        # hash[game.game_id][0]+=1
        game_total += 1
        if game.result == "WIN"
          win_total += 1
        end
      end
      # require "pry"; binding.pry
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

end
# --- PS NOTES --- #
# hash {wins => 0, games => 0, avg_win_pct => 0.to_f}  --- < Better way to
# label key value pairs vs line's 176's less readable way
