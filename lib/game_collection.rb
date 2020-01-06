require_relative './game'
require_relative './team'
require 'csv'

class GameCollection
attr_reader :games

  def create_games(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    csv.map do |row|
      Game.new(row)
    end
  end

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def highest_total_score
    highest_scoring_game = @games.max_by do |game|
      game.home_goals + game.away_goals
    end
    highest_scoring_game.home_goals + highest_scoring_game.away_goals
  end

  def lowest_total_score
    lowest_scoring_game = @games.min_by do |game|
      game.home_goals + game.away_goals
    end
    lowest_scoring_game.home_goals + lowest_scoring_game.away_goals
  end

  def biggest_blowout
    blowout = @games.max_by do |game|
      (game.home_goals - game.away_goals).abs
    end
    (blowout.home_goals - blowout.away_goals).abs
  end

  def percentage_home_wins
    (@games.count {|game| game.home_goals > game.away_goals} / @games.size.to_f ).round(2)
  end

  def percentage_visitor_wins
    (@games.count {|game| game.away_goals > game.home_goals} / @games.size.to_f ).round(2)
  end

  def percentage_ties
     (@games.count {|game| game.away_goals == game.home_goals} / @games.size.to_f ).round(2)
  end

  def count_of_games_by_season
    games_per_season.reduce({}) do |output, game|
      output[game[0]] = game[1].length
      output
    end
  end

  def average_goals_per_game
    game_goals_total = @games.sum {|game| game.away_goals + game.home_goals}
    (game_goals_total / @games.length.to_f).round(2)
  end

  def average_goals_by_season
    games_per_season.reduce({}) do |result, season|
      sum_goals = season[1].sum do |game|
        game.away_goals + game.home_goals
      end
      result[season[0]] = (sum_goals/season[1].size.to_f).round(2)
      result
    end
  end

  def games_per_season
    @games_per_season ||= @games.group_by{|game| game.season}
  end

  def worst_offense
 team_hash = @games.reduce({}) do |team_id, game|
  team_id[game.home_team_id] = {goals_scored: 0, games_played: 0}
  team_id[game.away_team_id] = {goals_scored: 0, games_played: 0}
  team_id
 end
 @games.each do |game|
   team_hash[game.home_team_id][:games_played] += 1
   team_hash[game.away_team_id][:games_played] += 1
   team_hash[game.away_team_id][:goals_scored] += game.away_goals
   team_hash[game.home_team_id][:goals_scored] += game.home_goals
 end
 team_worst_offense = team_hash.min_by do |team, info|
   info[:goals_scored].to_f / info[:games_played]
 end[0]
 team_worst_offense_id = team_worst_offense.to_s
  Team.team_id_to_team_name(team_worst_offense_id)
end

def best_offense
 team_hash = @games.reduce({}) do |team_id, game|
  team_id[game.home_team_id] = {goals_scored: 0, games_played: 0}
  team_id[game.away_team_id] = {goals_scored: 0, games_played: 0}
  team_id
 end
 @games.each do |game|
   team_hash[game.home_team_id][:games_played] += 1
   team_hash[game.away_team_id][:games_played] += 1
   team_hash[game.away_team_id][:goals_scored] += game.away_goals
   team_hash[game.home_team_id][:goals_scored] += game.home_goals
 end
 team_worst_offense = team_hash.max_by do |team, info|
   info[:goals_scored].to_f / info[:games_played]
 end[0]
 team_worst_offense_id = team_worst_offense.to_s
  Team.team_id_to_team_name(team_worst_offense_id)
end

def worst_defense
  team_hash = @games.reduce({}) do |team_id, game|
    team_id[game.home_team_id] = {goals_let: 0, games_played: 0}
    team_id[game.away_team_id] = {goals_let: 0, games_played: 0}
    team_id
end
  @games.each do |game|
    team_hash[game.home_team_id][:games_played] += 1
    team_hash[game.away_team_id][:games_played] += 1
    team_hash[game.away_team_id][:goals_let] += game.home_goals
    team_hash[game.home_team_id][:goals_let] += game.away_goals
  end
  team_worst_defense = team_hash.max_by do |team, info|
    info[:goals_let].to_f / info[:games_played]
  end[0]
  team_worst_defense_id = team_worst_defense.to_s
    Team.team_id_to_team_name(team_worst_defense_id)
  end

def best_defense
 team_hash = @games.reduce({}) do |team_id, game|
  team_id[game.home_team_id] = {goals_let: 0, games_played: 0}
  team_id[game.away_team_id] = {goals_let: 0, games_played: 0}
  team_id
 end
 @games.each do |game|
   team_hash[game.home_team_id][:games_played] += 1
   team_hash[game.away_team_id][:games_played] += 1
   team_hash[game.away_team_id][:goals_let] += game.home_goals
   team_hash[game.home_team_id][:goals_let] += game.away_goals
 end
 team_worst_defense = team_hash.min_by do |team, info|
   info[:goals_let].to_f / info[:games_played]
 end[0]
 team_worst_defense_id = team_worst_defense.to_s
  Team.team_id_to_team_name(team_worst_defense_id)
end

end
