require "csv"

class StatTracker
  def self.from_csv(locations)
    games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    new(games_data, teams_data, game_teams_data)
  end
  attr_accessor :games_data, :teams_data, :game_teams_data
  def initialize(games_data, teams_data, game_teams_data)
    @games_data = games_data
    @teams_data = teams_data
    @game_teams_data = game_teams_data
  end

  def highest_total_score
    highest_score = 0

    @games_data.each do |game|
      total_score = (game[:home_goals].to_i + game[:away_goals].to_i)

      highest_score = total_score if total_score > highest_score
      highest_score.round(1)
    end

    highest_score
  end

  def lowest_total_score
    lowest_score = 100

    @games_data.each do |game|
      total_score = (game[:home_goals].to_i + game[:away_goals].to_i)

      lowest_score = total_score if total_score < lowest_score
      lowest_score.round(1)
    end

    lowest_score
  end

  def percentage_home_wins(team)
    home_games = 0
    home_wins = 0
    @games_data.each do |game|
      if game[:home_team_id] == team
        home_games += 1
        if game[:home_goals].to_i > game[:away_goals].to_i
          home_wins += 1
        end
      end
    end

    if home_games != 0
      (home_wins.to_f/home_games * 100.0).round(1)
    else
      "no home games recorded"
    end
  end

  def percentage_visitor_wins(team)
    visitor_games = 0
    visitor_wins = 0
    # require "byebug"; byebug
    @games_data.each do |game|
      if game[:away_team_id] == team
        visitor_games += 1
        if game[:away_goals].to_i > game[:home_goals].to_i
          visitor_wins += 1
        end
      end
    end

    if visitor_games != 0
      (visitor_wins.to_f/visitor_games * 100.0).round(1)
    else
      "no visitor games recorded"
    end
  end

  def most_tackles(season)
    season_team_tackles = Hash.new(0)

    @games_data.each do |game|
      if game[:season] == season
        game_id = game[:game_id]
          @game_teams_data.each do |game_team|
            if game_team[:game_id] == game_id
              team_id = game_team[:team_id]
              if season_team_tackles.key?(team_id)
                season_team_tackles[team_id] += game_team[:tackles].to_i
              else
                season_team_tackles[team_id] = game_team[:tackles].to_i           
              end
            end
          end
      end
    end
    max_team_tackles = season_team_tackles.max_by { |team_id, tackles| tackles }
    
    team_name_from_id(max_team_tackles[0])
  end

  def team_name_from_id(team_id)
    @teams_data.each do |tm|
      return tm[:teamname] if tm[:team_id] == team_id
    end
  end

  def fewest_tackles(season)
    
  end
end
