require 'csv'
require 'spec_helper'

class StatTracker 
  attr_reader :games, :teams, :game_teams

  def initialize(locations_details)
    @games = []
    @teams = []
    @game_teams = []
    instantiate_teams(locations_details[:teams])
    instantiate_games(locations_details[:games])
    instantiate_game_teams(locations_details[:game_teams])
  end

  def self.from_csv(locations)
    # csv_team_data = CSV.open locations[:teams], headers: true, header_converters: :symbol
    # csv_games_data = CSV.open locations[:games], headers: true, header_converters: :symbol
    # csv_game_team_data = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
    StatTracker.new(locations)
  end

  def instantiate_games(locations)
    games = CSV.open(locations, headers: true, header_converters: :symbol)
    games.map do |row| 
      @games << Game.new({
      game_id: row[:game_id],
      season: row[:season],
      away_team_id: row[:away_team_id], 
      home_team_id: row[:home_team_id], 
      away_goals: row[:away_goals], 
      home_goals: row[:home_goals]})
    end
  end

  def instantiate_game_teams(locations)
    game_team_info = CSV.open(locations, headers: true, header_converters: :symbol)
    game_team_info.map do |row| 
      @game_teams << GameTeam.new({
       game_id: row[:game_id],
       team_id: row[:team_id],
       hoa: row[:hoa],
       result: row[:result],
       settled_in:  row[:settled_in],
       head_coach: row[:head_coach],
       goals: row[:goals],
       shots: row[:shots],
       tackles: row[:tackles],
       pim: row[:pim],
       power_play_opportunities: row[:power_play_opportunities],
       power_play_goals: row[:power_play_goals],
       face_off_win_percentage: row[:face_off_win_percentage],
      giveaways: row[:giveaways],
       takeaways: row[:takeaways]})
    end
  end

  def instantiate_teams(locations)
    teams = CSV.open(locations, headers: true, header_converters: :symbol)
    teams.map do |row| 
      @teams << Team.new({
        team_id: row[:team_id],
        franchise_id: row[:franchise_id],
        team_name: row[:team_name],
        abbreviation: row[:abbreviation],
        link: row[:link]})
    end
  end
end