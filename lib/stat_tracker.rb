require "csv"
require "./lib/game_collection"
require "./lib/team_collection"
require "./lib/game_team_collection"
require "./lib/team"

class StatTracker

  def initialize(location)
    @games = GameCollection.new(location[:games])
    @teams = TeamCollection.new(location[:teams])
    @game_teams = GameTeamCollection.new(location[:game_teams])
  end
  def self.from_csv(location)
    StatTracker.new(location)
  end

  def games
    @games.all
  end

  def teams
    @teams.all
  end

  def game_teams
    @game_teams.all
  end

  def team_info(team_id)
    # uses teams.csv
    return_hash = {}
    @teams.all.each do |team|
      if team.team_id == team_id.to_s
        return_hash = team.to_hash
      end
    end
    return_hash
  end

  def best_season(team_id)
    #String
    # Season with the highest win percentage for a team.
    # uses game_teams.csv and games.csv
    game_teams_array = []
    games_array = []
    combined_array = []
    win_hash = Hash.new(0)
    loss_hash = Hash.new(0)
    tie_hash = Hash.new(0)
    @game_teams.all.each do |game_team|
      if game_team.team_id == team_id.to_s
        game_teams_array << game_team.to_hash
      end
    end
    @games.all.each do |game|
      if game.home_team_id == team_id.to_s || game.away_team_id == team_id.to_s
        games_array << game.to_hash
      end
    end
    #combines arrays created from game_teams.csv and games.csv
    games_array.each do |game|
      game_teams_array.each do |game_team|
        if game_team[:game_id] == game[:game_id]
          combined_array << [game_team[:game_id], game_team[:result], game[:season]]
        end
      end
    end
    # binding.pry
    combined_array.each do |array|
      win_hash[array[2]] += 1 if array[1] == "WIN"
      loss_hash[array[2]] += 1 if array[1] == "LOSS"
      tie_hash[array[2]] += 1 if array[1] == "TIE"
    end
    win_hash = win_hash.sort.to_h
    loss_hash = loss_hash.sort.to_h
    tie_hash = tie_hash.sort.to_h
    win_hash_values = win_hash.values
    loss_hash_values = loss_hash.values
    tie_hash_values = tie_hash.values
    team_best_season = []

    win_hash.size.times do |x|
      team_best_season[x] = ((win_hash_values[x]).to_f / (win_hash_values[x] +
                              loss_hash_values[x] + tie_hash_values[x]))
    end
    win_hash.to_a[team_best_season.index(team_best_season.max)][0]
  end

  def worst_season(team_id)
    #String
    # Season with the lowest win percentage for a team.
    # uses game_teams.csv and games.csv
    game_teams_array = []
    games_array = []
    combined_array = []
    win_hash = Hash.new(0)
    loss_hash = Hash.new(0)
    tie_hash = Hash.new(0)
    @game_teams.all.each do |game_team|
      if game_team.team_id == team_id.to_s
        game_teams_array << game_team.to_hash
      end
    end
    @games.all.each do |game|
      if game.home_team_id == team_id.to_s || game.away_team_id == team_id.to_s
        games_array << game.to_hash
      end
    end
    #combines arrays created from game_teams.csv and games.csv
    games_array.each do |game|
      game_teams_array.each do |game_team|
        if game_team[:game_id] == game[:game_id]
          combined_array << [game_team[:game_id], game_team[:result], game[:season]]
        end
      end
    end
    # binding.pry
    combined_array.each do |array|
      win_hash[array[2]] += 1 if array[1] == "WIN"
      loss_hash[array[2]] += 1 if array[1] == "LOSS"
      tie_hash[array[2]] += 1 if array[1] == "TIE"
    end
    win_hash = win_hash.sort.to_h
    loss_hash = loss_hash.sort.to_h
    tie_hash = tie_hash.sort.to_h
    win_hash_values = win_hash.values
    loss_hash_values = loss_hash.values
    tie_hash_values = tie_hash.values
    team_best_season = []

    win_hash.size.times do |x|
      team_best_season[x] = ((win_hash_values[x]).to_f / (win_hash_values[x] +
                              loss_hash_values[x] + tie_hash_values[x]))
    end
    win_hash.to_a[team_best_season.index(team_best_season.min)][0]
  end

  def average_win_percentage
    #Float
    # Average win percentage of all games for a team.
    
  end
  #
  # def most_goals_scored
  #   #Integer
  #   # Highest number of goals a particular team has scored in a single game.
  # end
  #
  # def fewest_goals_scored
  #   #Integer
  #   # Lowest numer of goals a particular team has scored in a single game.
  # end
  #
  # def favorite_opponent
  #   #String
  #   # Name of the opponent that has the lowest win percentage against the given
  #   # team.
  # end
  #
  # def rival
  #   #String
  #   # Name of the opponent that has the highest win percentage against the
  #   # given team.
  # end

end
