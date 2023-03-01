require 'csv'

class GameTeamData
  attr_reader :game_teams
  def initialize
    @game_teams = []
    @teams = []
  end

  def add_game_team
    games = CSV.open './data/game_teams.csv', headers: true, header_converters: :symbol
    games.each do |row|
      game_id = row[:game_id]
      team_id = row[:team_id]
      hoa = row[:hoa]
      result = row[:result]
      settled_in = row[:settled_in]
      head_coach = row[:head_coach]
      goals = row[:goals]
      shots = row[:shots]
      tackles = row[:tackles]
      pim = row[:pim]
      powerplayopportunities = row[:powerplayopportunities]
      powerplaygoals = row[:powerplayGoals]
      faceoffwinpercentage = row[:faceoffwinpercentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]
      @game_teams << GameTeam.new(game_id,team_id,hoa,result,settled_in,head_coach,goals,shots,tackles,pim,powerplayopportunities,powerplaygoals,faceoffwinpercentage,giveaways,takeaways)
    end
  end

  #Name of the team with the highest average number of goals scored per game across all seasons.
  def best_offense
    average_goals_per_team = self.average_goals_per_team
    best_team_id = average_goals_per_team.sort_by { |_,v| v }.last[0]
    convert_id_to_teamname(best_team_id)
  end

  #Name of the team with the lowest average number of goals scored per game across all seasons.
  def worst_offense
    average_goals_per_team = self.average_goals_per_team
    best_team_id = average_goals_per_team.sort_by { |_,v| v }.first[0]
    convert_id_to_teamname(best_team_id)
  end
  
  #Helper method for best offense/ worst offense
  def convert_id_to_teamname(id_string)
    teamdata = TeamData.new
    teamdata.add_teams
    team = teamdata.teams.select{|team|team.team_id == id_string}
    team[0].teamname
  end

  #Helper method for best offense/ worst offense
  def average_goals_per_team
    goals_per_team = self.goals_per_team
    games_per_team = self.games_per_team
    average_goals_per_team = Hash.new(0)
    goals_per_team.each do |key, value|
      average_goals_per_team[key] = goals_per_team[key].to_f/games_per_team[key].to_f
    end
    average_goals_per_team
  end

  #Helper method for best offense/ worst offense
  def goals_per_team
    goals_per_team = Hash.new(0)
    @game_teams.each do |game|
      goals_per_team[game.team_id] += game.goals.to_i
    end
    goals_per_team
  end

  #Helper method for best offense/ worst offense
  def games_per_team
    games_per_team = Hash.new(0)
    @game_teams.each do |game|
      games_per_team[game.team_id] += 1
    end
    games_per_team
  end

  def home_games_per_team
    home_games_hash = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == "home"
        home_games_hash[game.team_id] += 1
      end
    end
    home_games_hash
  end

  def away_games_per_team
    away_games_hash = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == "away"
        away_games_hash[game.team_id] += 1
      end
    end
    away_games_hash
  end

  def highest_scoring_home_team
    gamedata = GameData.new
    gamedata.add_games
    scores = Hash.new(0)
    gamedata.games.each do |game|
      scores[(game.away)] += (game.away_goals).to_i
      scores.max_by{|k,v| v}[0]
      end
    numer = scores.max_by{|k, v| v}
    denom = home_games_per_team.max_by{|k, v| v}
    highest_avg = numer[1].div(denom[1])
    convert_id_to_teamname(numer[0])
  end
  

  def highest_scoring_away_team
    gamedata = GameData.new
    gamedata.add_games
    scores = Hash.new(0)
    gamedata.games.each do |game|
      scores[(game.away)] += (game.away_goals).to_i
      scores.max_by{|k,v| v}[0]
      end
    numer = scores.max_by{|k, v| v}
    denom = away_games_per_team.max_by{|k, v| v}
    highest_avg = numer[1].div(denom[1])
    convert_id_to_teamname(numer[0])
  end
  
  def winningest_coach
  win_loss = Hash.new(0)
  @game_teams.each do |game|
    if game.result == 'WIN'
      win_loss[game.head_coach] += 1
    elsif game.result == 'LOSS'
      win_loss[game.head_coach] -= 1
    end
  end
  winningest = win_loss.max_by{|k,v| v}[0]
end

  def worst_coach
    win_loss = Hash.new(0)
    @game_teams.each do |game|
      if game.result == 'WIN'
        win_loss[game.head_coach] += 1
      elsif game.result == 'LOSS'
        win_loss[game.head_coach] -= 1
      end
    end
    winningest = win_loss.min_by{|k,v| v}[0]
  end
end