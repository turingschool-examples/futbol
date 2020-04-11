require "csv"

class Game
  @@all = nil

  def self.all
    @@all
  end

  def self.find_by(id)
   @@all.find_all{|game| game.game_id==id}
  end

  def self.grouped_by_season(passed_in_season)
    @@all.select{|game| game.season == passed_in_season}
  end

  def self.from_csv(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    @@all = csv.map { |row| Game.new(row) }
  end

  def self.count_of_games_by_season
    games_by_season = @@all.group_by { |game| game.season }
    count = {}
    games_by_season.keys.each do |key|
      count[key] = @@all.count { |game| game.season == key}
    end
    count
  end

#deliverable
  def self.average_goals_per_game
    sum = all.sum { |game| game.away_goals + game.home_goals}.to_f
    (sum / all.length.to_f).round(2)
  end

#MODULE!
  def self.hash_of_hashes(collection, key1, key2, key3, value2, value3, arg2 = nil )
    # {key1 => { key2 => value2, key3 => value3}} across collection. arg2 is ignored if not needed
    # arg2 is optional if the passed method requires arguments
    hash_of_hashes = Hash.new { |hash, key| hash[key] = {key2 => 0, key3 => 0}}
    collection.each do |game|
      hash_of_hashes[game.send(key1)][key2] += game.send(value2) if arg2.nil?
      hash_of_hashes[game.send(key1)][key2] += game.send(value2, arg2) if !arg2.nil?
      hash_of_hashes[game.send(key1)][key3] += value3
    end
    hash_of_hashes
  end

#MODULE!
  def self.divide_hash_values(key1, key2, og_hash)
    # accumulator hash {season => win%}
    hash_divided = Hash.new { |hash, key| hash[key] = 0 }
    # divide 2 hashe values and send to new hash value
    og_hash.map do |key, value|
      hash_divided[key] = (value[key1] / value[key2].to_f).round(2)
    end
    hash_divided
  end

  def self.games_goals_by_season
    hash_of_hashes(all, :season, :goals, :games_played, :total_goals, 1)
  end

  #deliverable
    def self.average_goals_by_season
      # :goals / :games_played
      divide_hash_values(:goals, :games_played, games_goals_by_season)
    end

  def self.games_goals_by(hoa_team)
    #{away_team_id => {goals => x, games_played => y}}
    if hoa_team == :away_team
      hash_of_hashes(all, :away_team_id, :goals, :games_played, :away_goals, 1)
    elsif hoa_team == :home_team
      hash_of_hashes(all, :home_team_id, :goals, :games_played, :home_goals, 1)
    end
  end

  def self.average_goals_by(hoa_team)
      divide_hash_values(:goals, :games_played, games_goals_by(hoa_team))
  end

  def self.highest_scoring_visitor_team_id
    average_goals_by(:away_team).max_by{ |team_id, away_goals| away_goals}.first
  end
  def self.highest_scoring_home_team_id
    average_goals_by(:home_team).max_by{ |team_id, away_goals| away_goals}.first
  end
  def self.lowest_scoring_visitor_team_id
    average_goals_by(:away_team).min_by{ |team_id, away_goals| away_goals}.first
  end
  def self.lowest_scoring_home_team_id
    average_goals_by(:home_team).min_by{ |team_id, away_goals| away_goals}.first
  end

  def self.games_played_by(team_id)
    #return all games that team played in
    all.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
  end

  def self.games_and_wins_by_season(team_id)
      #{ season => {:wins => x, :games_played => y}}
    hash_of_hashes(games_played_by(team_id), :season, :wins, :games_played, :win?, 1, team_id)
  end

  def self.win_percent_by_season(team_id)
    # :wins / :games_played * 100
    win_percent_by_season = divide_hash_values(:wins, :games_played, games_and_wins_by_season(team_id))
    win_percent_by_season.transform_values { |v| (v * 100).to_i}
  end

#deliverable
  def self.best_season(team_id)
    #return season with highest winning percentage
    best_season = win_percent_by_season(team_id).max_by { |season, percent| percent}
    "In the #{best_season[0]} season Team #{team_id} won #{best_season[1]}% of games"
  end

#deliverable
  def self.worst_season(team_id)
    #return season with lowest winning percentage
      worst_season = win_percent_by_season(team_id).min_by { |season, percent| percent}
      "In the #{worst_season[0]} season Team #{team_id} won #{worst_season[1]}% of games"
  end

  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link,
              :total_goals

  def initialize(game_stats)
    @game_id = game_stats[:game_id].to_i
    @season = game_stats[:season].to_i
    @type = game_stats[:type]
    @date_time = game_stats[:date_time]
    @away_team_id = game_stats[:away_team_id].to_i
    @home_team_id = game_stats[:home_team_id].to_i
    @away_goals = game_stats[:away_goals].to_i
    @home_goals = game_stats[:home_goals].to_i
    @venue = game_stats[:venue]
    @venue_link = game_stats[:venue_link]
    @total_goals = @away_goals + @home_goals
  end

  def highest_total_score
    @@all.map { |game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @@all.map { |game| game.away_goals + game.home_goals}.min
  end

  def win?(team_id)
    away_win = team_id == @away_team_id && @away_goals > @home_goals
    home_win =  team_id == @home_team_id && @home_goals > @away_goals
    return 1 if away_win || home_win
    0
  end

end
