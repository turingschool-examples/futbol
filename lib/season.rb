require 'csv'
require_relative './game'

class Season < Game
  attr_reader :hoa, :result

  @@all_seasons = []

  def self.all
    @@all_seasons
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

    @@all_seasons = csv.map {|row| Season.new(row)}
  end

  def initialize(league_info)
    @game_id = league_info[:game_id]
    @team_id = league_info[:team_id].to_i
    @hoa = league_info[:hoa]
    @result = league_info[:result]
    @settled_in = league_info[:settled_in]
    @head_coach = league_info[:head_coach]
    @shots = league_info[:shots].to_i
    @tackles = league_info[:tackles].to_i
    @pim = league_info[:pim].to_i
    @power_play_opportunities = league_info[:powerplayopportunities].to_i
    @power_play_goals = league_info[:powerplaygoals].to_i
    @face_off_win_percentage = league_info[:faceoffwinpercentage].to_i
    @giveaways = league_info[:giveaways].to_i
    @takeaways = league_info[:takeaways].to_i
  end

  def self.total_home_games_played
    total_home_games = @@all_seasons.reduce({}) do |acc, season|
      if acc.keys.include?(season.team_id) && season.hoa == "home"
        acc[season.team_id] += 1
      elsif season.hoa == "home"
        acc[season.team_id] = 1
      end
      acc
    end
  end

  def self.total_away_games_played
    total_away_games = @@all_seasons.reduce({}) do |acc, season|
      if acc.keys.include?(season.team_id) && season.hoa == "away"
        acc[season.team_id] += 1
      elsif season.hoa == "away"
        acc[season.team_id] = 1
      end
      acc
    end
  end

  def self.home_win_percentage
    total_home_games_played
    testy = @@all_seasons.reduce({}) do |acc, season|
      if acc.keys.include?(season.team_id) && (season.hoa == "home" && season.result == "WIN")
        acc[season.team_id] += 1
      elsif (season.hoa == "home" && season.result == "WIN")
        acc[season.team_id] = 1
      end
      acc
    end
    require "pry"; binding.pry
  end

  # def self.home_win_percentage
  #   @@all_seasons.reduce({0}) do |acc, season|
  #     require "pry"; binding.pry
  #     if acc.keys.include?(season.team_id)
  #       acc[season.team_id] =
  #     # {team_id => total wins / total games}
  #   end
  # end

  def self.best_fans

  end

  def self.winningest_team

  end
end
