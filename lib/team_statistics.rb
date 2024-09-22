class TeamStatistics
    attr_reader :teams,
                :stat_tracker,
                :games

    attr_accessor :team_info_hash

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

    def head_to_head(team_id)
        results = Hash.new { |hash, key| hash[key] = { wins: 0, losses: 0, win_percentage: 0.0} }

        @games.each do |game|
          if game.away_team_id == team_id
            opp_team_id = game.home_team_id
            if game.away_goals.to_i > game.home_goals.to_i
                results[opp_team_id][:wins] +=1
            else
                results[opp_team_id][:losses] += 1
            end            
          elsif game.home_team_id == team_id
            opp_team_id = game.away_team_id
            if game.home_goals.to_i > game.away_goals.to_i
            results[opp_team_id][:wins] += 1
            else
                results[opp_team_id][:losses] += 1
            end
          end
        end        

        results.each do |opp_team_id, record|
            total_games = record[:wins] + record[:losses]
            record[:win_percentage] = total_games > 0 ? (record[:wins].to_f / total_games).round(2) : 0.0                        
        end 

        results.transform_keys! { |id| team_name(id) }
        results
    end

    def rival(team_id)
        head_to_head_results = head_to_head(team_id)
        lowest_win_percentage = head_to_head_results.values.min_by { |record| record[:win_percentage] }
        rival = head_to_head_results.key(lowest_win_percentage)
        rival
    end

    def team_name(team_id)
        @teams.find { |team| team.team_id == team_id }.team_name
    end       
  
    def favorite_opponent(team_id)
       head_to_head_results = head_to_head(team_id)
       highest_win_percentage = head_to_head_results.values.max_by { |record| record[:highest_win_percentage]}
       favorite = head_to_head_results.key(highest_win_percentage)
       favorite
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

    def team_info(team_id)
        team_info_hash = {}  

    #  @teams.each do |team| 
       team = @teams.find { |team| team.team_id == team_id }
        #   if team.team_id == team_id
            team_info_hash = {  
                team_id: team.team_id, 
                franchise_id: team.franchiseId,
                team_name: team.team_name,
                abbreviation: team.abbreviation,
                link: team.link 
                }
    #      end
    #  end
    # binding.pry
        team_info_hash
    end                
end
