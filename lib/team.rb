class Team

  attr_reader :id,
              :franchise_id,
              :name,
              :abbreviation,
              :stadium,
              :link,
              :games

  def initialize(team_hash)
    @id           = team_hash[:team_id]
    @franchise_id = team_hash[:franchiseId]
    @name         = team_hash[:teamName]
    @abbreviation = team_hash[:abbreviation]
    @stadium      = team_hash[:Stadium]
    @link         = team_hash[:link]
    @games        = team_hash[:games]
  end

  def total_goals
    @games.values.sum { |game| goals_scored(game) }
  end

  def total_goals_allowed
    @games.values.sum { |game| goals_allowed(game) }
  end

  def total_away_goals
    @games.values.sum do |game|
      !home_team?(game) ? game.away_team[:goals] : 0
    end
  end

  def total_home_goals
    @games.values.sum do |game|
      home_team?(game) ? game.home_team[:goals] : 0
    end
  end

  def total_home_games
    @games.values.count { |game| home_team?(game) }
  end

  def total_away_games
    @games.values.count { |game| !home_team?(game) }
  end

  def total_wins
    @games.values.count { |game| win?(game) }
  end

  def home_team?(game)
    game.home_team[:id] == @id
  end

  def win?(game)
    home_team?(game) ? game.home_team[:result] == "WIN" : game.away_team[:result] == "WIN"
  end

  def tie?(game)
    game.home_team[:result] == "TIE"
  end

  def goals_scored(game)
    home_team?(game) ? game.home_team[:goals] : game.away_team[:goals]
  end

  def goals_allowed(game)
    home_team?(game) ? game.away_team[:goals] : game.home_team[:goals]
  end

  def shots_taken(game)
    home_team?(game) ? game.home_team[:shots] : game.away_team[:shots]
  end

  def tackles_made(game)
    home_team?(game) ? game.home_team[:tackles] : game.away_team[:tackles]
  end

  def opponent_id(game)
    home_team?(game) ? game.away_team[:id] : game.home_team[:id]
  end

  def opponent_win_percentage
    opponent_hash = {}
    @games.values.each do |game|
      if !opponent_hash.has_key?(opponent_id(game))
        opponent_hash[opponent_id(game)] = {
          games_won: win?(game) ? 1 : 0,
          games_played: 1
        }
      else
        opponent_hash[opponent_id(game)][:games_won] += 1 if win?(game)
        opponent_hash[opponent_id(game)][:games_played] += 1
      end
    end
    opponent_hash
  end

  def default_summary_hash
    {
      win_percentage:        0,
      total_goals_scored:    0,
      total_goals_against:   0,
      average_goals_scored:  0,
      average_goals_against: 0
    }
  end

  def summary
    regular_season = default_summary_hash
    postseason     = default_summary_hash
    num_regular_games    = 0
    num_postseason_games = 0

    @games.values.each do |game|
      if game.type == "Regular Season"
        regular_season[:win_percentage]        += 1 if win?(game)
        regular_season[:total_goals_scored]    += goals_scored(game)
        regular_season[:total_goals_against]   += goals_allowed(game)
        regular_season[:average_goals_scored]  += goals_scored(game)
        regular_season[:average_goals_against] += goals_allowed(game)
        num_regular_games += 1
      else
        postseason[:win_percentage]        += 1 if win?(game)
        postseason[:total_goals_scored]    += goals_scored(game)
        postseason[:total_goals_against]   += goals_allowed(game)
        postseason[:average_goals_scored]  += goals_scored(game)
        postseason[:average_goals_against] += goals_allowed(game)
        num_postseason_games += 1
      end
    end
    num_regular_games = num_regular_games == 0 ? 1 : num_regular_games.to_f
    num_postseason_games = num_postseason_games == 0 ? 1 : num_postseason_games.to_f

    regular_season[:win_percentage]        = (regular_season[:win_percentage] / num_regular_games).round(2)
    regular_season[:average_goals_scored]  = (regular_season[:average_goals_scored] / num_regular_games).round(2)
    regular_season[:average_goals_against] = (regular_season[:average_goals_against] / num_regular_games).round(2)

    postseason[:win_percentage]        = (postseason[:win_percentage] / num_postseason_games).round(2)
    postseason[:average_goals_scored]  = (postseason[:average_goals_scored] / num_postseason_games).round(2)
    postseason[:average_goals_against] = (postseason[:average_goals_against] / num_postseason_games).round(2)
    {
      regular_season: regular_season,
      postseason: postseason
    }
  end
end
