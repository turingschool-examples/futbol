require 'csv'

class GameTeam

  @@all = []

  def self.create_game_teams(csv_file_path)
    csv = CSV.read(csv_file_path, headers: true, header_converters: :symbol)

    all_game_team = csv.map do |row|
      GameTeam.new(row)
    end

    @@all = all_game_team
  end

  def self.all
    @@all
  end

  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  def initialize(game_team_parameter)
    @game_id = game_team_parameter[:game_id].to_i
    @team_id = game_team_parameter[:team_id].to_i
    @hoa = game_team_parameter[:hoa]
    @result = game_team_parameter[:result]
    @settled_in = game_team_parameter[:settled_in]
    @head_coach = game_team_parameter[:head_coach]
    @goals = game_team_parameter[:goals].to_i
    @shots = game_team_parameter[:shots].to_i
    @tackles = game_team_parameter[:tackles].to_i
    @pim = game_team_parameter[:pim].to_i
    @power_play_opportunities = game_team_parameter[:powerplayopportunities].to_i
    @power_play_goals = game_team_parameter[:powerplaygoals].to_i
    @face_off_win_percentage = game_team_parameter[:faceoffwinpercentage].to_f
    @giveaways = game_team_parameter[:giveaways].to_i
    @takeaways = game_team_parameter[:takeaways].to_i
  end

  def percentage_home_wins
    all_home_games = @@all.find_all do |game_team|
      game_team.hoa == "home"
    end
    home_wins = all_home_games.find_all do |game_team|
       game_team.result == "WIN"
    end
    ((home_wins.length / all_home_games.length.to_f) * 100).round(2)
  end

  def percentage_visitor_wins
    all_visitor_games = @@all.find_all do |game_team|
      game_team.hoa == "away"
    end
    visitor_wins = all_visitor_games.find_all do |game_team|
       game_team.result == "WIN"
    end
    ((visitor_wins.length / all_visitor_games.length.to_f) * 100).round(2)
  end

  def percentage_ties
  all_ties = @@all.find_all do |game_team|
       game_team.result == "TIE"
    end
    ((all_ties.length / @@all.length.to_f) * 100).round(2)
  end
end
