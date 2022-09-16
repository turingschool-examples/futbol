require 'csv'

class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data
  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end

  def percentage_home_wins
    wins =0
    @games_data.each do |row| 
      if row[:away_goals].to_i < row[:home_goals].to_i
        wins += 1
      end
    end
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_visitor_wins
    wins =0
    @games_data.each do |row| 
      if row[:away_goals].to_i > row[:home_goals].to_i
        wins += 1
      end
    end
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_ties
    ties =0 
    @games_data.each do |row| 
      if row[:away_goals].to_i == row[:home_goals].to_i
        ties += 1
      end
    end
    (ties.to_f/games_data.count).round(2)
  end











































#GameClass



































































































  #LeagueClass


































































































#end
  #SeasonClass


  #Method returns the name Coach with the best win percentage for the season in a string
  #look at every season
  #find coach name
  #accumulate coach's win/loss/tie
  #compare coach records with other for each season
  def winningest_coach(campaign)
    
    campaign = "2014020109"
    
    # season_all_game_id
    coach_games = Hash.new(0)
    wins = 0
    games = 0
    games_played = 
    season = Set.new

    @game_teams_data.each do |row|      
      #hash of coach (key) and count of games coached in a season (value)
      # require 'pry';binding.pry
      row.find_all do |game_id|
        if campaign.scan(/.{4}/).shift == row[:game_id].scan(/.{4}/).shift
          season << row[:game_id]
            end
          end
        end
                season

      coaches_for_each_game.each do |game, coaches|
        if season.include?(game)
        # require 'pry';binding.pry
          if coach_games .include?(game[:head_coach])
            coach_games [game[:head_coach]] += 1 
          else
            coach_games [game[:head_coach]] = 1 
          end
        end
        coach_games 
        require 'pry';binding.pry
      end
    # @game_teams_data.each do |row|
    #   if season == row[:game_id]
    #     row.each do |coaches|




                  # coach_games 
                  require 'pry';binding.pry

          
                            # require 'pry';binding.pry
          #  coaches.each do |coach|
          # require 'pry';binding.pry
          # if coach_games.include?(row[:head_coach])
          #   coach_games[row[:head_coach]] = [row[:game_id]]
          # else
          #   coach_games[row[:season]] = [row[:game_id]]
          # end
          #     end

  end

            # if coach_games.include?(game[:head_coach])
            #   coach_games[game[:head_coach]] = (games += 1)
            #       else
            #         coach_games[game[:head_coach]] = (games + 1) 
            #       end
            #       coach_games
            #       require 'pry';binding.pry
                # end

          
          # end
          # coaches_for_each_game.each do |game, result|
          #     # if row[:result] == "WIN"
          #     require 'pry';binding.pry
          #     if coach.include?(game[:head_coach])
          #       coach[game[:head_coach]] += 1 
          #       # && row[:result] == "WIN" 
          #           # wins += 1
          #     else
          #       coach[game[:head_coach]] = 1 
          #     end
          #     coach
          #     require 'pry';binding.pry
          #   end
          # end
        # end
      # end
          #   if row[:result] == "WIN" 
          #     wins += 1
          #  coach [ wins, total_games ]
          #         values[0]/values[1]
          #   coach [%]

    
  
  
    
  #method creates hash-season(key) and all games_id(values) in string
  def season_all_game_id
  season_games = {}
    @games_data.flat_map do |row|
        if season_games.include?(row[:season])
          season_games[row[:season]].push(row[:game_id])
        else #!season_games.include?(row[:season])
          season_games[row[:season]] = [row[:game_id]]
        end
    end
    season_games
  end

  #method returns a hash: game_id(key) = [team_id (away), team_id (home)]
  def game_match_up
    game_ids = {}
    @game_teams_data.each do |row|
      if game_ids.include?(row[:game_id])
        game_ids[row[:game_id]].push(row[:team_id])
      else #!game_ids.include?(row[:season])
        game_ids[row[:game_id]] = [row[:team_id]]
      end
    end
    game_ids
  end

  #method returns hash: game_id(key) coaches for those games(values)
  def coaches_for_each_game
    coach_games = Hash.new
    @game_teams_data.each do |row|
          if coach_games.include?(row[:game_id])
            coach_games[row[:game_id]].push(row[:head_coach])
          else# !coach_games.include?(row[:season])
            coach_games[row[:game_id]] = [row[:head_coach]]
          end
    end
        coach_games
  end
end