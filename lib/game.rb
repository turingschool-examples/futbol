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

  def self.average_goals_per_game
    sum = @@all.sum { |game| game.away_goals + game.home_goals}.to_f
    (sum / @@all.length.to_f).round(2)
  end

  def self.games_per(header)
    group_by_header = @@all.group_by { |game| game.send(header) }
    group_by_header.values.map{ |games| games.length}
  end

  # def self.goals_per(header)
  #   group_by_header = @@all.group_by { |game| game.send(header) }
  #   group_by_header.values.map do |games|
  #     games.sum { |game| (game.away_goals + game.home_goals)}
  #   end
  # end
  #
  # def self.away_goals_per(header)
  #   group_by_header = @@all.group_by { |game| game.send(header) }
  #   group_by_header.values.map do |games|
  #     games.sum { |game| (game.away_goals)}
  #   end
  # end
  #
  # def self.home_goals_per(header)
  #   group_by_header = @@all.group_by { |game| game.send(header) }
  #   group_by_header.values.map do |games|
  #     games.sum { |game| (game.home_goals)}
  #   end
  # end

#new
  def self.goals_per(header, goals)
    group_by_header = @@all.group_by { |game| game.send(header) }
    group_by_header.values.map do |games|
      games.sum { |game| (game.send(goals))}
    end
  end
#old but needed
  def self.home_away_goals_per(header)
    goals_per(header, :away_goals) + goals_per(header, :home_goals)
  end
#new
  def self.average_goals(sum_array, length_array)
    sum_array.each_with_index.map do |goals, index|
      (goals.to_f / length_array[index].to_f ).round(2)
    end
  end


  # def self.average_goals_per(header)
  #   home_away_goals_per(header).each_with_index.map do |goals, index|
  #     (goals.to_f/games_per(header)[index].to_f).round(2)
  #   end
  # end
  def self.average_goals_by_season
    goals =  Game.home_away_goals_per(:season)
    season_length = Game.games_per(:season)
    average_goals_per_season = Game.average_goals(goals, season_length)
    seasons = @@all.map { |game| game.season}.uniq
    Hash[seasons.zip(average_goals_per_season)]
  end

#not used
  def self.combine_to_hash(key_array, value_array)
    Hash[key_array.zip(value_array)]
  end

  # def self.average_goals_by_season
  #   seasons = @@all.map { |game| game.season}.uniq
  #   Hash[seasons.zip(Game.average_goals_per(:season))]
  # end
  #very similar to average_home_goals_per
  def self.average_away_goals_per(header)
    away_goals_per(header).each_with_index.map do |goals, index|
      (goals.to_f / games_per(header)[index].to_f).round(2)
    end
  end
  #very similar to average_away_goals_per
  def self.average_home_goals_per(header)
    home_goals_per(header).each_with_index.map do |goals, index|
      (goals.to_f / games_per(header)[index].to_f).round(2)
    end
  end
########
  def self.highest_scoring_visitor_team_id
    away_teams = @@all.map { |game| game.away_team_id }.uniq
    visitor_team_id_goals =
    Hash[away_teams.zip(Game.average_away_goals_per(:away_team_id))]
    # create hash of id => average_away_goals
    visitor_team_id_goals.max_by{ |team_id, away_goals| away_goals}.first
  end
#id like to combine these two
  def self.highest_scoring_home_team_id
    home_teams = @@all.map { |game| game.home_team_id }.uniq
    home_team_id_goals =
    Hash[home_teams.zip(Game.average_home_goals_per(:away_team_id))]
    # create hash of id => average_away_goals
    home_team_id_goals.max_by{ |team_id, home_goals| home_goals}.first
  end

  def self.lowest_scoring_visitor_team_id
    away_teams = @@all.map { |game| game.away_team_id }.uniq
    visitor_team_id_goals =
    Hash[away_teams.zip(Game.average_away_goals_per(:away_team_id))]
    # create hash of id => average_away_goals
    visitor_team_id_goals.min_by{ |team_id, away_goals| away_goals}.first
  end
#id like to combine these two
  def self.lowest_scoring_home_team_id
    home_teams = @@all.map { |game| game.home_team_id }.uniq
    home_team_id_goals =
    Hash[home_teams.zip(Game.average_home_goals_per(:away_team_id))]
    home_team_id_goals.min_by{ |team_id, home_goals| home_goals}.first
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
