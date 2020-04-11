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

#should be a module
  def self.hash_of_hashes(collection, key1, key2, key3, value2, value3, arg2 = 0 )
    #accumulator hash {season1 => {"goals" => 10, "games => 20"}}
    hash_of_hashes = Hash.new { |hash, key| hash[key] = {key2 => 0, key3 => 0}}
    collection.each do |game|
      hash_of_hashes[game.send(key1)][key2] += game.send(value2, arg2)
      hash_of_hashes[game.send(key1)][key3] += value3
    end
    hash_of_hashes
  end

#should be a module
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

  def self.games_per(csv_header)
    #returns number of games in a given (:season) or (:away_team_id)...
    group_by_header = all.group_by { |game| game.send(csv_header) }
    group_by_header.values.map{ |games| games.length}
  end

  def self.goals_per(csv_header, hoa_goals)
    #returns number of goals (:home_goals) or (:away_goals) in a given csv_header
    group_by_header = all.group_by { |game| game.send(csv_header) }
    group_by_header.values.map do |games|
      games.sum { |game| game.send(hoa_goals) }
    end
  end

  def self.average(sum_array, length_array)
    sum_array.each_with_index.map do |goals, index|
      (goals.to_f / length_array[index].to_f ).round(2)
    end
  end

#deliverable (needs to access teams.csv via stat_tracker)
  def self.highest_scoring_visitor_team_id
    avg_away_goals = average(goals_per(:away_team_id, :away_goals), games_per(:away_team_id))
    away_team_ids = all.map { |game| game.away_team_id }.uniq
    # create hash of {team_ids => average goals}
    away_ids_n_goals = Hash[away_team_ids.zip(avg_away_goals)]
    away_ids_n_goals.max_by{ |team_id, away_goals| away_goals}.first
  end
#deliverable (needs to access teams.csv via stat_tracker)
  def self.highest_scoring_home_team_id
    avg_home_goals = average(goals_per(:home_team_id, :home_goals), games_per(:home_team_id))
    home_team_ids = all.map { |game| game.home_team_id }.uniq
    # create hash of {team_ids => average goals}
    home_ids_n_goals = Hash[home_team_ids.zip(avg_home_goals)]
    home_ids_n_goals.max_by{ |team_id, home_goals| home_goals}.first
  end
#deliverable (needs to access teams.csv via stat_tracker)
  def self.lowest_scoring_visitor_team_id
    avg_away_goals = average(goals_per(:away_team_id, :away_goals), games_per(:away_team_id))
    away_team_ids = all.map { |game| game.away_team_id }.uniq
    # create hash of {team_ids => average goals}
    away_ids_n_goals = Hash[away_team_ids.zip(avg_away_goals)]
    away_ids_n_goals.min_by{ |team_id, away_goals| away_goals}.first
  end
#deliverable (needs to access teams.csv via stat_tracker)
  def self.lowest_scoring_home_team_id
    avg_home_goals = average(goals_per(:home_team_id, :home_goals), games_per(:home_team_id))
    home_team_ids = all.map { |game| game.home_team_id }.uniq
    # create hash of {team_ids => average goals}
    home_ids_n_goals = Hash[home_team_ids.zip(avg_home_goals)]
    home_ids_n_goals.min_by{ |team_id, home_goals| home_goals}.first
  end

  def self.games_played_by(team_id)
    #return all games that team played in
    all.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
  end

  def self.games_and_wins_by_season(team_id)
    #accumulator hash {season1 => {"wins" => 10, "games => 20"}}
    games_wins_by_season = Hash.new { |hash, key| hash[key] = {:wins => 0, :games_played => 0}}
    games_played_by(team_id).each do |game|
      games_wins_by_season[game.season][:wins] +=  game.win?(team_id)
      games_wins_by_season[game.season][:games_played] += 1 #if team_played_in_game
    end
    games_wins_by_season
  end


  def self.games_and_wins_by_season(team_id)
      #{ season => {:wins => x, :games_played => y}}
    hash_of_hashes(games_played_by(team_id), :season, :wins, :games_played, :win?, 1, team_id)
  end

  def self.win_percent_by_season(team_id)
    # :wins / :games_played * 100
    x = divide_hash_values(:wins, :games_played, games_and_wins_by_season(team_id))
    x.transform_values { |v| (v * 100).to_i}
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

  # def total_goals
  #   @away_goals
  # end



end
