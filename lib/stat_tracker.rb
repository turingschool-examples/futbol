require 'csv'

class StatTracker
 attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    StatTracker.new(
    CSV.read(locations[:games], headers: true, header_converters: :symbol),
    CSV.read(locations[:teams], headers: true, header_converters: :symbol),
    CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  )
  end

  def winningest_coach
    coaches_and_results = @game_teams[:result].zip @game_teams[:head_coach]
    wins = Hash.new(0)
    losses = Hash.new(0)
    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      losses[coach] += 1 if result == "LOSS"
    end
    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / (losses[coach] + num_wins)
    end

    win_percentage.max_by{|coach, percentage| percentage}.first
  end

  def worst_coach
    coaches_and_results = @game_teams[:result].zip @game_teams[:head_coach]
    wins = Hash.new(0)
    losses = Hash.new(0)
    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      losses[coach] += 1 if result == "LOSS"
    end
    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / (losses[coach] + num_wins)
    end

    win_percentage.max_by{|coach, percentage| -percentage}.first
  end

  def most_accurate_team
    i = 0
    per_game_accuracy = @game_teams[:shots].map do |shot|
      ratio = @game_teams[:goals][i].to_f / shot.to_f
      i += 1
      ratio
    end
    team_id_accuracy_arr = @game_teams[:team_id].zip per_game_accuracy
    team_id_accuracy_h = Hash.new{|hash, key| hash[key] = []}
    team_id_accuracy_arr.each do |game|
      team_id_accuracy_h[game[0]] << game[1]
    end
    team_id_highest_accuracy = team_id_accuracy_h.map do |id, acc|
      [id, acc.reduce(:+) / acc.length]
    end.max_by{|id, avg| avg}.first
    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[team_id_highest_accuracy]
  end
end
