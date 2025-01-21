require_relative './csv_helper'
require_relative './game'
require_relative './team'
require_relative './game_team'

class StatsHelper
  @@games = CSVHelper.gamesCSV('./data/games.csv')
  @@teams = CSVHelper.teamsCSV('./data/teams.csv')
  @@game_teams = CSVHelper.game_teamsCSV('./data/game_teams.csv')

  def self.seasons
    seasons = []
    
    @@games.each do |game|
      seasons << game.season if !seasons.include?(game.season)
    end

    seasons
  end

  def self.team_ids
    team_ids = []

    @@teams.each do |team|
      team_ids << team.team_id
    end

    team_ids
  end

  def self.coaches
    coaches = []

    @@game_teams.each do |game_teams|
      coaches << game_teams.head_coach if !coaches.include?(game_teams.head_coach)
    end

    coaches
  end
end