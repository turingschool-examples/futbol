require 'CSV'

class Game
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link

  def self.from_csv(data)
    Game.new(data)
  end

  def initialize(data)
    @game_id = data[0]
    @season = data[1]
    @type = data[2]
    @date_time = data[3]
    @away_team_id = data[4]
    @home_team_id = data[5]
    @away_goals = data[6]
    @home_goals = data[7]
    @venue = data[8]
    @venue_link = data[9]
  end

  def away_team_average_goals(away_team_id)
    away_teams_by_id = @games.find_all do |game|
      game.away_team_id.to_i == away_team_id
   end

    total_away_goals = away_teams_by_id.sum do |away_teams|
      away_teams.away_goals.to_i
    end
    (total_away_goals.to_f / away_teams_by_id.size).round(2)
  end

    def away_teams_sort_by_average_goal
      Games.all.sort_by do |game|
        away_team_average_goals(game.away_team_id.to_i)
      end
    end
end
