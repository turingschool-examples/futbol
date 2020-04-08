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

#one of THE METHODS ross
  def self.average_goals_per_game
    sum = @@all.sum { |game| game.away_goals + game.home_goals}.to_f
    (sum / @@all.length.to_f).round(2)
  end

  def self.games_per(header)
    group_by_header = @@all.group_by { |game| game.send(header) }
    group_by_header.values.map{ |games| games.length}
  end


  def self.goals_per(header, goals)
    group_by_header = @@all.group_by { |game| game.send(header) }
    group_by_header.values.map do |games|
      games.sum { |game| (game.send(goals))}
    end
  end

  def self.home_away_goals_per(header)
    goals_per(header, :away_goals) + goals_per(header, :home_goals)
  end

  def self.average_goals(sum_array, length_array)
    sum_array.each_with_index.map do |goals, index|
      (goals.to_f / length_array[index].to_f ).round(2)
    end
  end
#one of THE METHODS ross
  def self.average_goals_by_season
    goals = home_away_goals_per(:season)
    season_length = games_per(:season)
    average_goals_per_season = average_goals(goals, season_length)
    season_ids = @@all.map { |game| game.season}.uniq
    Hash[season_ids.zip(average_goals_per_season)]
  end
#FOUR of THE METHODS ross
  def self.nth_scoring_team_id(max_min_by, hoa_team_id, hoa_goals)
    team_ids = @@all.map { |game| game.send(hoa_team_id) }.uniq
    goals = goals_per(hoa_team_id, hoa_goals)
    games_length = games_per(hoa_team_id)
    avg_goals = average_goals(goals, games_length)
    team_id_goals = Hash[team_ids.zip(avg_goals)]
    team_id_goals.send(max_min_by){ |team_id, hoa_goals| hoa_goals}.first
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

end
