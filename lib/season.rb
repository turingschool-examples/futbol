require 'csv'
require './lib/games'

class Season < Games


  @@all_season = []

  def self.all
    @@all_season
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

    @@all_season = csv.map {|row| Season.new(row)}
  end

  def initialize(league_info)
    @game_id = league_info[:game_id]
    @team_id = league_info[:team_id]
    @HoA = league_info[:HoA]
    @result = league_info[:result]
    @settled_in = league_info[:settled_in]
    @head_coach = league_info[:head_coach]
    @shots = league_info[:shots]
    @tackles = league_info[:tackles]
    @pim = league_info[:pim]
    @power_play_opportunities = league_info[:power_play_opportunities]
    @power_play_goals = league_info[:power_play_goals]
    @face_off_win_percentage = league_info[:face_off_win_percentage]
    @giveaways = league_info[:giveaways]
    @takeaways = league_info[:takeaways]
  end

end
