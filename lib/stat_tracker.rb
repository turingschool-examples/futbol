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

  def average_win_percentage(team_id)
    #Float
    # Average win percentage of all games for a team.
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
    total = team_best_season.inject(:+)
    len = team_best_season.length
    average = total.to_f / len
    average.round(2)
  end

  def most_goals_scored(team_id)
    #Integer
    # Highest number of goals a particular team has scored in a single game.
    game_teams_array = []
    @game_teams.all.each do |game_team|
      if game_team.team_id == team_id.to_s
        game_teams_array << game_team.to_hash
      end
    end

    most_goals = game_teams_array.max_by do |game|
      game[:goals]
    end[:goals]
  end

  def fewest_goals_scored(team_id)
    #Integer
    # Lowest numer of goals a particular team has scored in a single game.
    game_teams_array = []
    @game_teams.all.each do |game_team|
      if game_team.team_id == team_id.to_s
        game_teams_array << game_team.to_hash
      end
    end
    game_teams_array.min_by do |game|
      game[:goals]
    end[:goals]
  end

  def find_team_by_id(team_id)
    @teams.all.find {|team| team.team_id == team_id}
  end

  def games_played_by_team(team_id)
    game_teams.find_all {|game| game.team_id == team_id.to_s}
  end

  def games_by_opponent_team(team_id)
    x = games_played_by_team(team_id).group_by{|game| game.game_id}
    games = @game_teams.all.select do |game|
       key = x.keys
       key.include?(game.game_id) && !x.values.flatten.include?(game)
    end
    games.group_by{|game| game.team_id}
  end

  def opponent_percentage_wins(team_id)
    x = games_by_opponent_team(team_id).transform_values do |games|
      wins = games.select{|game| game.result == "WIN"}.length
      (wins / games.size.to_f * 100).round(2)
    end
  end

  def favorite_opponent(team_id)
    id =opponent_percentage_wins(team_id).min_by{|k,v| v}.first
    find_team_by_id(id).team_name
  end

  def rival(team_id)
    id =opponent_percentage_wins(team_id).max_by{|k,v| v}.first
    find_team_by_id(id).team_name
  end

end
  # def favorite_opponent(team_id)
  #   #String
  #   # Name of the opponent that has the lowest win percentage against the given
  #   # team.
  #   # Needs teams.csv for `franchise_id`
  #   # Needs games.csv for `away_team_id`
  #   # Needs game_teams.csv for `result`
  #   game_teams_array = []
  #   games_array = []
  #   teams_array = []
  #   max = []
  #   combined_hash = Hash.new(0)
  #   combined_array = []
  #   opponents_array = []
  #   opponents_hash = {}
  #   win_counter_array = []
  #   loss_counter_array = []
  #   game_teams_array = @game_teams.all.find_all do |game_team|
  #     game_team.team_id == team_id.to_s
  #   end
  #   @games.all.each do |game|
  #     game_teams_array.each do |game_team|
  #       if game.game_id == game_team.game_id
  #         combined_hash[:game_id] = game.game_id
  #         combined_hash[:result] = game_team.result
  #         if game_team.to_hash[:hoa] == "away"
  #           combined_hash[:opponent] = game.home_team_id
  #         elsif game_team.to_hash[:hoa] == "home"
  #           combined_hash[:opponent] = game.away_team_id
  #         end
  #         combined_array << [combined_hash[:game_id], combined_hash[:result], combined_hash[:opponent]]
  #       end
  #     end
  #   end
  #
  #
  # end

  # def get_all_game_teams_by_id(team_id)
  #   @game_teams.all.find_all do ||
  # end
  #
  # def opponent_counter(team_id)
  #   hash = {}
  #   @game_teams.all.each do |game_team|
  #     selected_teams = favorite_opponent(game_team.team_id)
  #     all_wins = selected_teams.select{|team| team.result == "WIN"}.count
  #     all_loss = selected_teams.select{|team| team.result == "LOSS"}.count
  #     hash[game_team.team_id] = all_wins / selected_teams
  #   end
  # end

  # def rival
  #   #String
  #   # Name of the opponent that has the highest win percentage against the
  #   # given team.
