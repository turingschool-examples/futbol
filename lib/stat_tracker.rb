require 'csv'

class StatTracker

  attr_reader :seasons, :games
  def self.from_csv(data)
    seasons = CSV.read(data[:games], headers: true, header_converters: :symbol)
    games = CSV.read(data[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(seasons, games)
  end

  def initialize(seasons, games)
    @seasons = seasons
    @games = games
  end

  def games_coached(season_id)
    coaches = []
    new_season = @seasons.find_all {|row| row[:season] == season_id}
    new_season.each do |season|
      @games.each do |game|
        if season[:game_id] == game[:game_id]
          coaches << game[:head_coach]
        end
      end
    end
    games_coached_hash = Hash.new(0)
    coaches.each {|coach| games_coached_hash[coach] += 1}
    games_coached_hash
  end

  def games_won(season_id)
    winning_coaches = []
    new_season = @seasons.find_all {|row| row[:season] == season_id}
    new_season.each do |season|
      games.each do |game|
        if season[:game_id] == game[:game_id] && game[:result] == "WIN"
          winning_coaches << game[:head_coach]
        end
      end
    end
    coach_wins = Hash.new(0)
    winning_coaches.each {|coach| coach_wins[coach] += 1}
    coach_wins
  end

  def winning_percentage(season_id)
    coach_winning_percentage = Hash.new(0)
    games_won(season_id).each do |won_key, won_value|
      games_coached(season_id).each do |coached_key, coached_value|
        if won_key == coached_key
          coach_winning_percentage[coached_key] = (won_value.to_f / coached_value).round(3)
        end
      end
    end
    coach_winning_percentage
  end

  def winningest_coach(season_id)
    high_win_percentage = winning_percentage(season_id).max_by {|coach, percentage| percentage}
    high_win_percentage[0]
  end

end
