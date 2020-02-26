class GameTeam
  @@game_teams = {}

  def self.add(game_team)
    @@game_teams[game_team.game_id] = {} if !@@game_teams.has_key?(game_team.game_id)
    @@game_teams[game_team.game_id][game_team.team_id] = game_team
  end

  def self.all
    @@game_teams
  end

  def self.season_games(games)
      @@game_teams.select do |game_id, gameteam|
        games.keys.include?(game_id)
      end
  end

  def self.matching_games(games)
    @@game_teams.select do |game_id, gameteam|
      games.keys.include?(game_id)
    end
  end

  def self.coaches_with_team_id(games)
    gamesteams = GameTeam.matching_games(games)
    coaches = {}
    gamesteams.each_value do |gameteam|
      gameteam.each_value do |team|
        coaches[team.head_coach] = [] if !coaches.has_key?(team.head_coach)
        coaches[team.head_coach] << team.result
      end
    end
    coaches
  end

  def self.game_outcomes(season, rank = nil)
    coaches = GameTeam.coaches_with_team_id(Game.games_in_a_season(season))
    if rank == "worst"
      results = coaches.min_by do |coach, game_results|
        game_results.count("WIN") / game_results.count.to_f
      end
    else
      results = coaches.max_by do |coach, game_results|
        game_results.count("WIN") / game_results.count.to_f
      end
    end
    results
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

  def initialize(data)
    @game_id = data[:game_id]
    @team_id = data[:team_id]
    @hoa = data[:hoa]
    @result = data[:result]
    @settled_in = data[:settled_in]
    @head_coach = data[:head_coach]
    @goals = data[:goals]
    @shots = data[:shots]
    @tackles = data[:tackles]
    @pim = data[:pim]
    @power_play_opportunities = data[:powerplayopportunities]
    @power_play_goals = data[:powerplaygoals]
    @face_off_win_percentage = data[:faceoffwinpercentage]
    @giveaways = data[:giveaways]
    @takeaways = data[:takeaways]
  end

end
