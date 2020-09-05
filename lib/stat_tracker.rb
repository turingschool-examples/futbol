class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = transform_games(games)
    @teams = transform_teams(teams)
    @game_teams = transform_game_teams(game_teams)
  end

  private
  Game = Struct.new(:game_id, :season, :type, :date_time, :away_team_id,
              :home_team_id, :away_goals, :home_goals, :venue, :venue_link)

  def transform_games(games)
    games.map do |game|
      Game.new(game[0], game[1], game[2], game[3], game[4], game[5],
                game[6], game[7], game[8], game[9])
    end
  end

  Team = Struct.new(:team_id, :franchise_id, :team_name, :abbreviation,
                      :stadium, :link)

  def transform_teams(teams)
    teams.map do |team|
      Team.new(team[0], team[1], team[2], team[3], team[4], team[5])
    end
  end

  GameTeams = Struct.new(:game_id, :team_id, :hoa, :result, :settled_in,
                        :head_coach, :goals, :shots, :tackles, :pim,
                        :power_play_opportunities, :power_play_goals,
                        :face_off_win_percentage, :giveaways, :takeaways)
  def transform_game_teams(game_teams)
    game_teams.map do |game_team|
      GameTeams.new(game_teams[0], game_teams[1], game_teams[2], game_teams[3],
                    game_teams[4], game_teams[5], game_teams[6], game_teams[7],
                    game_teams[8], game_teams[9], game_teams[10], game_teams[11],
                    game_teams[12], game_teams[13], game_teams[14])
    end
  end
end