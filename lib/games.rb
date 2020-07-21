class Games
  attr_reader :away_team_id, :away_goals

  @@games = []

  def initialize(info)
    @game_id = info[:game_id]
    @season = info[:season]
    @type = info[:type]
    @date_time = info[:date_time]
    @away_team_id = info[:away_team_id]
    @home_team_id = info[:home_team_id]
    @away_goals = info[:away_goals]
    @home_goals = info[:home_goals]
    @venue = info[:venue]
    @venue_link = info[:venue_link]
  end

  def self.add(game)
    @@games << game
  end

  def self.all
    @@games
  end

  def self.remove_all
    @@team = []
  end

  def self.away_team_average_goals(away_team_id)
    away_teams_by_id = @@games.find_all do |game|
      game.away_team_id.to_i == away_team_id
   end

    total_away_goals = away_teams_by_id.sum do |away_teams|
      away_teams.away_goals.to_i
    end
    (total_away_goals.to_f / away_teams_by_id.size).round(2)
  end

    def self.away_teams_sort_by_average_goal
      Games.all.sort_by do |game|
        away_team_average_goals(game.away_team_id.to_i)
      end
    end
end
