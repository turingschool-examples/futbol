class TeamStatistics
    attr_reader :teams,
                :stat_tracker,
                :games

    def initialize(teams,games, stat_tracker)
        @teams = teams
        @games = games
        @stat_tracker = stat_tracker
    end

    def team_name(team_id)
        @teams[team_id]&.team_name
    end

    def count_of_teams
        @teams.size
    end

    def most_goals_scored(team_id)
        goals = 0
        @games.each do |game|
            if game.away_team_id == team_id && game.away_goals.to_i > goals
                goals = game.away_goals.to_i
            end
            
            if game.home_team_id == team_id && game.home_goals.to_i > goals
                goals = game.home_goals.to_i
            end
        end
        goals
    end

    def fewest_goals_scored(team_id)
        goals = 99
        @games.each do |game|
            if game.away_team_id == team_id && game.away_goals.to_i < goals
                goals = game.away_goals.to_i
            end
            
            if game.home_team_id == team_id && game.home_goals.to_i < goals
                goals = game.home_goals.to_i
            end
        end
        goals
    end

    def worst_loss(team_id)
        max_loss = 0
    @games.each do |game|
      if game.away_team_id == team_id
        loss_margin = game.home_goals.to_i - game.away_goals.to_i
        max_loss = loss_margin if loss_margin > max_loss
      end
      #if the away team is the selected team, get the loss margin and if 
      #it is the worst one so far, put it as the value of max_loss, until all 
      #examples have been looked at

      if game.home_team_id == team_id
        loss_margin = game.away_goals.to_i - game.home_goals.to_i
        max_loss = loss_margin if loss_margin > max_loss
      end
    end
    max_loss
  end
        
    


    def biggest_team_blowout(team_id)
        max_blowout = 0
    @games.each do |game|
      if game.away_team_id == team_id
        blowout_margin = game.away_goals.to_i - game.home_goals.to_i
        max_blowout = blowout_margin if blowout_margin > max_blowout
      end

      if game.home_team_id == team_id
        blowout_margin = game.home_goals.to_i - game.away_goals.to_i
        max_blowout = blowout_margin if blowout_margin > max_blowout
      end
    end
    max_blowout
  end

 end