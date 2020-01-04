require 'csv'

class League

  @@all_leagues = []

  def self.all
    @@all_leagues
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

    @@all_leagues = csv.map {|row| League.new(row)}
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

  def self.count_of_teams
    # @@all_leagues.map do ||
  end

  def self.best_offense
    sum = @@all_leagues.sum do |testy|
      (testy.away_goals + testy.home_goals)
    end
    (sums / @@all_leagues.length.to_f).round(2)
  end

  def self.worst_offense

  end

  def self.best_defence

  end

  def self.worst_defense

  end

  def self.highest_scoring_visitor

  end

  def self.highest_scoring_home_team

  end

  def self.lowest_scoring_visitor

  end

  def self.lowest_scoring_home_team

  end

  def self.winningest_team

  end

  def self.best_fans

  end

  def self.worst_fans

  end
end
