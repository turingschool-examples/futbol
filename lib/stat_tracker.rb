require_relative 'helper_class'

class StatTracker
  attr_reader :data, 
              :team_file,
              :game_file,
              :game_team_file

  def initialize(data)
    @data = data
    require 'pry'; binding.pry
    @game_file ||= CSV.foreach(data[:games], headers: true, header_converters: :symbol) { |row| Season.new(row) }
    @team_file ||= CSV.foreach(data[:teams], headers: true, header_converters: :symbol) { |row| Team.new(row) }
    @game_team_file ||= CSV.foreach(data[:game_teams], headers: true, header_converters: :symbol) { |row| GameTeam.new(row) }
  end
  
  def rewind(file)
    file.rewind
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end
  
  def create_teams
    @team_file.each do |team|
      @teams << Teams.new(team)
    end
  end
  
  def count_of_teams
    @teams.count
  end
  
  def create_seasons
    season_finder.each do |season|
      season_id = season
      game_count = count_of_games_by_season(season)
      games_played = seasonal_game_collector(season)
      avg_goals = average_goals_per_game(season)
      # winningest_coach = winningest_coach(season)
      @seasons << Season.new(season, count_of_games_by_season(season), seasonal_game_collector(season), average_goals_per_game(season))
    end
  end

  def create_games
    @game_file.each do |game|
      @games << Game.new(game, @team_file)
    end
  end

  def create_game_team
    @game_team_file.each do |game_team|
      @game_teams << Game.new(game_team, @team_file)
    end
  end

  
  def season_finder
    all_seasons = @game_file.map { |row| row[:season] }.uniq
    rewind(@game_file)
    all_seasons
  end
  
  def count_of_games_by_season(season)
    game_count = @game_file.count { |game| game[:season] == season }
    rewind(@game_file)
    game_count
  end

  def seasonal_game_collector(season)
    seasonal = @game_file.find_all { |game| game[:season] == season }
    rewind(@game_file)
    seasonal.flat_map { |row| row[:game_id] }
  end

  def average_goals_per_game(season)
    total_goals = @game_file.sum { |game| game[:away_goals] + game[:home_goals] }
    rewind(@game_file) 
    total_goals / count_of_games_by_season(season)
  end

  # def winningest_coach(season)
  #   @game_team_file.max_by { |row|}

end