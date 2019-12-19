require 'csv'

class GameTeam
  @@all_game_teams

  def self.all_game_teams
    @@all_game_teams
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @@all_game_teams = csv.map do |row|
                    GameTeam.new(row)
                  end
  end

  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles

  def initialize(game_team_info)
    @game_id = game_team_info[:game_id]
    @team_id = game_team_info[:team_id]
    @hoa = game_team_info[:hoa]
    @result = game_team_info[:result]
    @settled_in = game_team_info[:settled_in]
    @head_coach = game_team_info[:head_coach]
    @goals = game_team_info[:goals]
    @shots = game_team_info[:shots]
    @tackles = game_team_info[:tackles]
  end

  def self.percent_home_wins
    count_game = 0
    count_win = 0
    @@all_game_teams.each do |game_team|
      if game_team.result == "WIN" && game_team.hoa == "home"
        count_game += 1
        count_win += 1
      elsif game_team.result == "LOSS" && game_team.hoa == "home"
        count_game += 1
      end
    end
    (count_win/count_game.to_f).round(2)
  end

  def self.percent_visitor_wins
    count_game = 0
    count_win = 0
    @@all_game_teams.each do |game_team|
      if game_team.result == "WIN" && game_team.hoa == "away"
        count_game += 1
        count_win += 1
      elsif game_team.result == "LOSS" && game_team.hoa == "away"
        count_game += 1
      end
    end
    (count_win/count_game.to_f).round(2)
  end

  def self.percent_ties
    total_games = @@all_game_teams.map {|game_team| game_team.game_id}.uniq.length
    count_tie = 0
    @@all_game_teams.each {|game_team| count_tie += 1 if game_team.result == "TIE" && game_team.hoa == "home"}
    (count_tie/total_games.to_f).round(2)
  end
end
