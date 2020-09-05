require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = transform_games(games)
    @teams = transform_teams(teams)
    @game_teams = transform_game_teams(game_teams)
  end

  def self.from_csv(locations)
    games = CSV.read(locations[:games])
    teams = CSV.read(locations[:teams])
    game_teams = CSV.read(locations[:game_teams])

    new(games, teams, game_teams)
  end

#------------GameStatistics

  def highest_total_score
    result = games.max_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    result.away_goals.to_i + result.home_goals.to_i
  end

  def lowest_total_score
    result = games.min_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    result.away_goals.to_i + result.home_goals.to_i
  end

#------------TeamStatistics

  def team_info
    result = { }
    teams.each do |team|
      (result[:team_id]||=[]) << team.team_id
      (result[:franchise_id]||=[]) << team.franchise_id
      (result[:team_name]||=[]) << team.team_name
      (result[:abbreviation]||=[]) << team.abbreviation
      (result[:link]||=[]) << team.link
    end
    result
  end

#---------------------------
  private

  Game = Struct.new(:game_id, :season, :type, :date_time, :away_team_id,
                    :home_team_id, :away_goals, :home_goals, :venue, :venue_link)

  def transform_games(games)
    games.map do |cell|
      Game.new(cell[0], cell[1], cell[2], cell[3], cell[4], cell[5],
               cell[6], cell[7], cell[8], cell[9])
    end
  end

  Team = Struct.new(:team_id, :franchise_id, :team_name, :abbreviation,
                    :stadium, :link)

  def transform_teams(teams)
    teams.map do |cell|
      Team.new(cell[0], cell[1], cell[2], cell[3], cell[4], cell[5])
    end
  end

  GameTeams = Struct.new(:game_id, :team_id, :hoa, :result, :settled_in,
                         :head_coach, :goals, :shots, :tackles, :pim,
                         :power_play_opportunities, :power_play_goals,
                         :face_off_win_percentage, :giveaways, :takeaways)

  def transform_game_teams(game_teams)
    game_teams.map do |cell|
      GameTeams.new(cell[0], cell[1], cell[2], cell[3], cell[4], cell[5],
                    cell[6], cell[7], cell[8], cell[9], cell[10], cell[11],
                    cell[12], cell[13], cell[14])
    end
  end
end
