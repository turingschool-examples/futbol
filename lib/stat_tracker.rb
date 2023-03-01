require 'csv'
require_relative 'classes'
require_relative 'game_stats'
require_relative 'season_stats'
require_relative 'league_stats'

class StatTracker
  attr_reader :game_stats,
              :league_stats,
              :season_stats

  def self.from_csv(locations)
    new(locations)
  end

  def initialize(locations)
    @game_stats = GameStats.new(locations)
    @league_stats = LeagueStats.new(locations)
    @season_stats = SeasonStats.new(locations)
  end


  # def self.from_csv(locations)
  #   games = CSV.read locations[:games], headers: true, header_converters: :symbol
  #   games.each do |row|
  #     id = row[:game_id]
  #     season = row[:season]
  #     type = row[:type]
  #     date_time = row[:date_time]
  #     away = row[:away_team_id]
  #     home = row[:home_team_id]
  #     away_goals = row[:away_goals]
  #     home_goals = row[:home_goals]
  #     venue = row[:venue]
  #     venue_link = row[:venue_link]
  #     @@games << Game.new(id, season, type, date_time, away, home, away_goals, home_goals, venue, venue_link)
  #   end

  #   game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  #   game_teams.each do |row|
  #     game_id = row[:game_id]
  #     team_id = row[:team_id]
  #     hoa = row[:hoa]
  #     result = row[:result]
  #     settled_in = row[:settled_in]
  #     head_coach = row[:head_coach]
  #     goals = row[:goals]
  #     shots = row[:shots]
  #     tackles = row[:tackles]
  #     pim = row[:pim]
  #     powerplayopportunities = row[:powerplayopportunities]
  #     powerplaygoals = row[:powerplayGoals]
  #     faceoffwinpercentage = row[:faceoffwinpercentage]
  #     giveaways = row[:giveaways]
  #     takeaways = row[:takeaways]
  #     @@game_teams << GameTeam.new(game_id, team_id, hoa, result, settled_in, head_coach,goals, shots, tackles, pim, powerplayopportunities, powerplaygoals, faceoffwinpercentage, giveaways, takeaways)
  #   end

  #   teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
  #   teams.each do |row|
  #     team_id = row[:team_id]
  #     franchiseid = row[:franchiseid]
  #     teamname = row[:teamname]
  #     abbreviation = row[:abbreviation]
  #     stadium = row[:stadium]
  #     link = row[:link]
  #     @@teams << Team.new(team_id, franchiseid, teamname, abbreviation, stadium, link)
  #   end
  # end

  def self.games
    @@games
  end

  def self.teams
    @@teams
  end

  def self.game_teams
    @@game_teams
  end
end