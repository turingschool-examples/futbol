require 'csv'

class StatTracker
  attr_reader :games_data, :games, :teams, :game_teams

  def initialize(csv_games_data, csv_game_team_data, csv_team_data)
    @games = []
    @teams = []
    @game_teams = []
    @games_data = parse_games_data(csv_games_data)
    @game_team_data = parse_game_team_data(csv_game_team_data)
    @team_data = parse_team_data(csv_team_data)
  end

  def self.from_csv(locations)
    csv_games_data = CSV.open locations[:games], headers: true, header_converters: :symbol
    csv_game_team_data = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
    csv_team_data = CSV.open locations[:teams], headers: true, header_converters: :symbol
    StatTracker.new(csv_games_data, csv_game_team_data, csv_team_data)
  end

  def parse_games_data(data)
    data_hash = {}
    data.each do |row|
      data_hash[:game_id] = row[:game_id]
      data_hash[:season]  = row[:season]
      data_hash[:type] = row[:type]
      data_hash[:date_time] = row[:date_time]
      data_hash[:away_team_id] = row[:away_team_id]
      data_hash[:home_team_id] = row[:home_team_id]
      data_hash[:away_goals] = row[:away_goals]
      data_hash[:home_goals] = row[:home_goals]
      data_hash[:venue] = row[:venue]
      @games << Game.new(data_hash)
    end
  end

  def parse_team_data(data)
    data_hash = {}
    data.each do |row|
      data_hash[:team_id] = row[:team_id]
      data_hash[:franchise_id] = row[:franchiseid]
      data_hash[:team_name] = row[:teamname]
      data_hash[:abbreviation] = row[:abbreviation]
      data_hash[:stadium] = row[:stadium]
      @teams << Team.new(data_hash)
    end
  end

  def parse_game_team_data(data)
    data_hash = {}
    data.each do |row|
      data_hash[:game_id] = row[:game_id]
      data_hash[:team_id]  = row[:team_id]
      data_hash[:hoa] = row[:hoa]
      data_hash[:result] = row[:result]
      data_hash[:settled_in] = row[:settled_in]
      data_hash[:head_coach] = row[:head_coach]
      data_hash[:goals] = row[:goals]
      data_hash[:shots] = row[:shots]
      data_hash[:tackles] = row[:tackles]
      data_hash[:pim] = row[:pim]
      data_hash[:powerplayopportunities] = row[:powerplayopportunities]
      data_hash[:powerplaygoals] = row[:powerplaygoals]
      data_hash[:faceoffwinpercentage] = row[:faceoffwinpercentage]
      data_hash[:giveaways] = row[:giveaways]
      data_hash[:takeaways] = row[:takeaways]
      @game_teams << GameTeam.new(data_hash)
    end
  end
end
