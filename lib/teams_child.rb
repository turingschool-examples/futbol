require './lib/futbol_csv_reader'

class TeamsChild < CSVReader

  def initialize(locations)
    super(locations)
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

  def game_teams_by_team(team_id)
    @game_teams.select do |row|
      row.team_id == team_id
    end
  end

  def team_name(id)
    @teams.find do |row|
      row.team_id == id
    end.team_name.to_s
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
end
