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

  def highest_total_score
    max = @games.map {|game| game.home_goals + game.away_goals }.max
  end

  def lowest_total_score
    min = @games.map {|game| game.home_goals + game.away_goals }.min
  end

  def percentage_home_wins
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @total_games = 0
    @game_teams.each do |game|
      @total_games += 0.50
      @key = game.game_id
      @value_array = []
      @value1 = game.result
      @value2 = game.hoa
      @value_array << @value1
      @value_array << @value2
      hash[@key] = @value_array
    end
    @home_win = 0.00
    hash.values.each do |hashy|
      if hashy[0] == "WIN" && hashy[1] == "home"
        @home_win += 1.00
      end
    end
    x = @home_win / @total_games
    (x * 100).round(2)
  end

  def percentage_visitor_wins
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @total_games = 0
    @game_teams.each do |game|
      @total_games += 0.50
      @key = game.game_id
      @value_array = []
      @value1 = game.result
      @value2 = game.hoa
      @value_array << @value1
      @value_array << @value2
      hash[@key] = @value_array
    end
    @visitor_win = 0.00
    hash.values.each do |hashy|
      if hashy[0] == "LOSS" && hashy[1] == "home"
        @visitor_win += 1.00
      end
    end
    x = @visitor_win / @total_games
    (x * 100).round(2)
  end

  def percentage_ties
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @total_games = 0
    @game_teams.each do |game|
      @total_games += 0.50
      @key = game.game_id
      @value_array = []
      @value1 = game.result
      @value2 = game.hoa
      @value_array << @value1
      @value_array << @value2
      hash[@key] = @value_array
    end
    @tie = 0.00
    hash.values.each do |hashy|
      if hashy[0] == "TIE" && hashy[1] == "home"
        @tie += 1.00
      end
    end
    x = @tie / @total_games
    (x * 100).round(2)
  end

  def count_of_games_by_season
    games_per_season = Hash.new(0)
    @games.each do |game|
      games_per_season[game.season] += 1
    end
    games_per_season
  end

  #take all the home goals, add to all the away goals, and divide by number of games
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
end



  # original from_csv left for reference
  # def self.from_csv(locations)
  #   content = {}
  #   content[:teams] = CSV.readlines(locations[:teams], headers: true, header_converters: :symbol),
  #   content[:games] = CSV.readlines(locations[:games], headers: true, header_converters: :symbol),
  #   content[:game_teams] = CSV.readlines(locations[:game_teams], headers: true, header_converters: :symbol)
  #   StatTracker.new(content)
  ## in pry you can then do stat_tracker[:team_id] and it will print stuff
  # end