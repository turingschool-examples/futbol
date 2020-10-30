class Season
    attr_reader :team_id, :season_id, :game_teams

    def initialize(team_id, season_id, game_teams, parent)
        @team_id      = team_id
        @season_id    = season_id
        @game_teams   = game_teams
        @parent       = parent
    end

    # # def games_by_team
    #     total_games = Hash.new(0)
    #     game_teams.each do |game_team|
    #       total_games[game_team.team_id] += 1
    #     end
    #     total_games
    # end

    def total_goals
      game_teams.sum do |game_team|
        game_team[:goals].to_i
      end
    end

    def total_games
      game_teams.count
    end

    def away_game
      game_teams.count do |game_team|
        if game_team[:hoa] == "away"
          game_team
        end
      end
    end

    def home_game
      game_teams.count do |game_team|
        if game_team[:hoa] == "home"
          game_team
        end
      end
    end

    def away_goals
      require 'pry'; binding.pry
      game_teams.sum do |game_team|
        if game_team[:hoa] == "away"
          game_team[:goals].to_i
        end
      end
    end

    def home_goals
      game_teams.sum do |game_team|
        if game_team[:hoa] == "home"
          game_team[:goals].to_i
        end
      end
    end
  # def average_goals_by_team
    # average = Hash.new(0)
    # game_teams.each do |game_team|
    #   average[game_team.team_id] += game_team.goals
    # end
    # games_by_team.merge(average) do |key, games, goals|
    #   (goals.to_f / games).round(2)
    # end
  # end
end
