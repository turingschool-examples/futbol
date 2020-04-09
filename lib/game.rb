require "csv"

class Game
  @@all = nil

  def self.all
    @@all
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
    sum = @@all.sum { |game| game.away_goals + game.home_goals}.to_f
    (sum / @@all.length.to_f).round(2)
  end

  def self.games_per(csv_header)
    group_by_header = @@all.group_by { |game| game.send(csv_header) }
    group_by_header.values.map{ |games| games.length}
  end


  def self.goals_per(csv_header, hoa_goals)
    group_by_header = @@all.group_by { |game| game.send(csv_header) }
    group_by_header.values.map do |games|
      games.sum { |game| (game.send(hoa_goals))}
    end
  end

  def self.total_goals_per(csv_header)
    goals_per(csv_header, :away_goals) + goals_per(csv_header, :home_goals)
  end

  def self.average_goals(sum_array, length_array)
    sum_array.each_with_index.map do |goals, index|
      (goals.to_f / length_array[index].to_f ).round(2)
    end
  end
#deliverable
  def self.average_goals_by_season
    avg_goals_per_season = average_goals(total_goals_per(:season), games_per(:season))
    season_ids = @@all.map { |game| game.season}.uniq
    Hash[season_ids.zip(avg_goals_per_season)]
  end

#deliverable (needs to access teams.csv via stat_tracker)
  def self.highest_scoring_visitor_team_id
    avg_away_goals = average_goals(goals_per(:away_team_id, :away_goals), games_per(:away_team_id))
    away_team_ids = @@all.map { |game| game.away_team_id }.uniq

    away_ids_n_goals = Hash[away_team_ids.zip(avg_away_goals)]
    away_ids_n_goals.max_by{ |team_id, away_goals| away_goals}.first
  end
#deliverable (needs to access teams.csv via stat_tracker)
  def self.highest_scoring_home_team_id
    avg_home_goals = average_goals(goals_per(:home_team_id, :home_goals), games_per(:home_team_id))
    home_team_ids = @@all.map { |game| game.home_team_id }.uniq

    home_ids_n_goals = Hash[home_team_ids.zip(avg_home_goals)]
    home_ids_n_goals.max_by{ |team_id, home_goals| home_goals}.first
  end
  #deliverable (needs to access teams.csv via stat_tracker)
  def self.lowest_scoring_visitor_team_id
    avg_away_goals = average_goals(goals_per(:away_team_id, :away_goals), games_per(:away_team_id))
    away_team_ids = @@all.map { |game| game.away_team_id }.uniq

    away_ids_n_goals = Hash[away_team_ids.zip(avg_away_goals)]
    away_ids_n_goals.min_by{ |team_id, away_goals| away_goals}.first
  end
  #deliverable (needs to access teams.csv via stat_tracker)
  def self.lowest_scoring_home_team_id
    avg_home_goals = average_goals(goals_per(:home_team_id, :home_goals), games_per(:home_team_id))
    home_team_ids = @@all.map { |game| game.home_team_id }.uniq

    home_ids_n_goals = Hash[home_team_ids.zip(avg_home_goals)]
    home_ids_n_goals.min_by{ |team_id, home_goals| home_goals}.first
  end

  def self.win?(team_id, game_id)
    game = @@all.find {|game| game.game_id == game_id}
    away_win = team_id == game.away_team_id && game.away_goals > game.home_goals
    home_win =  team_id == game.home_team_id && game.home_goals > game.away_goals
    away_win || home_win
  end

  def self.games_by_season(team_id)
    games_by_season = Hash.new { |hash, key| hash[key] = 0 }
    @@all.each do |game|
      games_by_season[game.season] += 1 if game.away_team_id == team_id || game.home_team_id == team_id
    end
    games_by_season
  end

  def self.wins_by_season(team_id)
    season_wins = Hash.new { |hash, key| hash[key] = 0 }
    @@all.each do |game|
      season_wins[game.season] += 1 if win?(team_id, game.game_id)
      season_wins[game.season] if game.away_team_id == team_id || game.home_team_id == team_id
    end
    season_wins
  end

  def self.percent_by_season(team_id)
    num_games = games_by_season(team_id).values
    percent_per_season = wins_by_season(team_id).values.each_with_index.map do |wins, index|
      ((wins.to_f / num_games[index].to_f)*100).to_i
    end

    Hash[games_by_season(team_id).keys.zip(percent_per_season)]
  end

#deliverable
  def self.best_season(team_id)
    best_season = percent_by_season(team_id).max_by { |season, percent| percent}
    "In the #{best_season[0]} season Team #{team_id} won #{best_season[1]}% of games"
  end

  #deliverable
  def self.worst_season(team_id)
      worst_season = percent_by_season(team_id).min_by { |season, percent| percent}
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
              :venue_link

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
  end

  def highest_total_score
    @@all.map { |game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @@all.map { |game| game.away_goals + game.home_goals}.min
  end
end
