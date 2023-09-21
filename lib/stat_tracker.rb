require "csv"
class StatTracker
  attr_reader :teams,
              :games,
              :game_teams
  def initialize(content)
    @teams = content[:teams]
    @games = content[:games]
    @game_teams = content[:game_teams]
  end

  def self.from_csv(locations)
    # convert each CSV into an array of associated instance objects, ie. teams_arry holds an array of Team objects
    teams_arry = CSV.readlines(locations[:teams], headers: true, header_converters: :symbol).map { |team| Team.new(team) }
    games_arry = CSV.readlines(locations[:games], headers: true, header_converters: :symbol).map { |game| Game.new(game) }
    game_teams_arry = CSV.readlines(locations[:game_teams], headers: true, header_converters: :symbol).map { |game_team| GameTeam.new(game_team)}
    # combine all arrays to be stored in a Hash so we can easily call each array
    contents = {
      teams: teams_arry,
      games: games_arry,
      game_teams: game_teams_arry
    }
    # pass contents hash on to StatTracker to initiate the class.
    StatTracker.new(contents)
  end
# Game Statistic Method
  def highest_total_score
    max = @games.map {|game| game.home_goals + game.away_goals }.max
  end

  def lowest_total_score
    min = @games.map {|game| game.home_goals + game.away_goals }.min
  end

  def percentage_home_wins
    hash = Hash.new{ |hash, key| hash[key] = [] }
    total_games = 0
    @game_teams.each do |game|
      total_games += 0.50
      key = game.game_id
      value_array = []
      value1 = game.result
      value2 = game.hoa
      value_array << value1
      value_array << value2
      hash[key] = value_array
    end
    home_win = 0.00
    hash.values.each do |hashy|
      if hashy[0] == "WIN" && hashy[1] == "home"
        home_win += 1.00
      end
    end
    x = home_win / total_games
    (x * 100).round(2)
  end

  def percentage_visitor_wins
    hash = Hash.new{ |hash, key| hash[key] = [] }
    total_games = 0
    @game_teams.each do |game|
      total_games += 0.50
      key = game.game_id
      value_array = []
      value1 = game.result
      value2 = game.hoa
      value_array << value1
      value_array << value2
      hash[key] = value_array
    end
    visitor_win = 0.00
    hash.values.each do |hashy|
      if hashy[0] == "LOSS" && hashy[1] == "home"
        visitor_win += 1.00
      end
    end
    x = visitor_win / total_games
    (x * 100).round(2)
  end

  def percentage_ties
    hash = Hash.new{ |hash, key| hash[key] = [] }
    total_games = 0
    @game_teams.each do |game|
      total_games += 0.50
      key = game.game_id
      value_array = []
      value1 = game.result
      value2 = game.hoa
      value_array << value1
      value_array << value2
      hash[key] = value_array
    end
    tie = 0.00
    hash.values.each do |hashy|
      if hashy[0] == "TIE" && hashy[1] == "home"
        tie += 1.00
      end
    end
    x = tie / total_games
    (x * 100).round(2)
  end


  def count_of_games_by_season
    games_per_season = Hash.new(0)
    @games.each do |game|
      games_per_season[game.season] += 1
    end
    games_per_season
  end


  def average_goals_per_game
    @home_goals = 0.0
    @away_goals = 0.0
    @games.each do |game|
      @home_goals += game.home_goals
      @away_goals += game.away_goals
    end
    total_goals = @home_goals+@away_goals
    number_of_games = @games.count
    @average_goals = (total_goals/number_of_games)
    @average_goals.round(2)
  end

  def average_goals_by_season
    hash = Hash.new{ |hash, key| hash[key] = 0.00 }
    total_goals = 0.00
    total_games = 0.00
    @games.each do |game|
      key = game.season
      value1 = game.away_goals
      value2 = game.home_goals
      total_games += 1.00
      total_goals += value1
      total_goals += value2
      avg_goals_game = (total_goals / total_games)
      hash[key] = avg_goals_game
    end
    hash
  end
# League Statistic Methods
  def count_of_teams
    @teams.count
  end

  def best_offense
    teams_goals_average = {}
    @teams.each do |team|
      total_games = 0
      total_goals = 0
      games = @game_teams.each do |game_team| 
        if game_team.team_id == team.team_id
          total_games +=1
          total_goals += game_team.goals
        end
      end
      if total_games > 0 && total_goals
      teams_goals_average["#{team.name}"] = (total_goals.to_f / total_games.to_f)
      end
    end
    best_offense = teams_goals_average.find { |team, avg| avg == teams_goals_average.values.max}
    best_offense.first
  end

  def worst_offense
    teams_goals_average = {}
    @teams.each do |team|
      total_games = 0
      total_goals = 0
      games = @game_teams.each do |game_team| 
        if game_team.team_id == team.team_id
          total_games +=1
          total_goals += game_team.goals
        end
      end
      if total_games > 0 && total_goals
      teams_goals_average["#{team.name}"] = (total_goals.to_f / total_games.to_f)
      end
    end
    worst_offense = teams_goals_average.find { |team, avg| avg == teams_goals_average.values.min}
    worst_offense.first
  end
end
#Season Statistic Methods
  def winningest_coach
    #number of wins for each coach
    coach_wins = Hash.new(0)
    @game_teams.each do |row|
      if row.result == "WIN"
        coach_wins[row.head_coach] += 1
      end
    end
    #number of games played by each coach's team
    coach_total_games = Hash.new(0)
    @game_teams.each do |row|
      coach_total_games[row.head_coach] += 1
    end
    #now we divide each coach's wins by the number of games their team played
    coach_win_percentage = {}
    coach_wins.each do |coach, wins|
        coach_win_percentage["#{coach}"] = (wins.to_f/coach_total_games["#{coach}"].to_f)
    end
    winningest_coach = coach_win_percentage.find{ |key, value| value  == coach_win_percentage.values.max }
    winningest_coach.first
  end

  def worst_coach
    coach_losses = Hash.new(0)
    @game_teams.each do |row|
      if row.result == "LOSS"
        coach_losses[row.head_coach] += 1
      end
    end
    #number of games played by each coach's team
    coach_total_games = Hash.new(0)
    @game_teams.each do |row|
      coach_total_games[row.head_coach] += 1
    end
    #now we divide each coach's wins by the number of games their team played
    coach_loss_percentage = {}
    coach_losses.each do |coach, losses|
        coach_loss_percentage["#{coach}"] = (losses.to_f/coach_total_games["#{coach}"].to_f)
    end
    worst_coach = coach_loss_percentage.find{ |key, value| value  == coach_loss_percentage.values.min }
    worst_coach.first
    require 'pry'; binding.pry
  end
end

