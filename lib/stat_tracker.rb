require 'csv'

class StatTracker
 attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    StatTracker.new(
    CSV.read(locations[:games], headers: true, header_converters: :symbol),
    CSV.read(locations[:teams], headers: true, header_converters: :symbol),
    CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  )
  end

  def winningest_coach(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end

    coaches_and_results= game_teams.map do |game|
                            [game[:result], game[:head_coach]]
                          end

    wins = Hash.new(0)
    all_games = Hash.new(0)

    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      all_games[coach] += 1
    end

    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / all_games[coach]
    end

    win_percentage.max_by{|coach, percentage| percentage}.first
  end

  def worst_coach(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    coaches_and_results= game_teams.map do |game|
                            [game[:result], game[:head_coach]]
                          end

    wins = Hash.new(0)
    all_games = Hash.new(0)

    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      all_games[coach] += 1
      wins[coach] += 0
    end

    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / all_games[coach]
    end

    win_percentage.max_by{|coach, percentage| -percentage}.first
  end

  def most_accurate_team(target_season)
    games = @games.to_a.select do |game|
              game[1] == target_season
            end
    game_ids = games.map do |game|
                game[0]
               end
    game_teams = @game_teams.to_a.select do |game_team|
                    game_ids.include?(game_team[0])
                  end
    per_game_accuracy = game_teams.map do |game|
                          [game[1], (game[6].to_f / game[7].to_f)]
                        end

    team_id_accuracy_h = Hash.new{|hash, key| hash[key] = []}
    per_game_accuracy.each do |game|
      team_id_accuracy_h[game[0]] << game[1] == 0 ? 0 : game[1]
    end
    # require "pry"; binding.pry
    team_id_highest_accuracy = team_id_accuracy_h.map do |id, acc|
      [id, acc.sum / acc.count]
    end.max_by{|id, avg| avg}.first
    # require "pry"; binding.pry

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[team_id_highest_accuracy]

  end

  def least_accurate_team(target_season)
    games = @games.to_a.select do |game|
              game[1] == target_season
            end
    game_ids = games.map do |game|
                game[0]
               end
    game_teams = @game_teams.to_a.select do |game_team|
                    game_ids.include?(game_team[0])
                  end
    per_game_accuracy = game_teams.map do |game|
                          [game[1], (game[6].to_f / game[7].to_f)]
                        end
    team_id_accuracy_h = Hash.new{|hash, key| hash[key] = []}
    per_game_accuracy.each do |game|
      team_id_accuracy_h[game[0]] << game[1]
    end
    team_id_lowest_accuracy = team_id_accuracy_h.map do |id, acc|
      [id, acc.reduce(:+) / acc.length]
    end.max_by{|id, avg| -avg}.first
    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[team_id_lowest_accuracy]
  end

  def most_tackles(target_season)
    games = @games.to_a.select do |game|
              game[1] == target_season
            end
    game_ids = games.map do |game|
                game[0]
               end
    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end
    id_tackles = Hash.new(0)
    game_teams.each do |game|
      id_tackles[game[:team_id]] += game[:tackles].to_i
    end

    most_tackles = id_tackles.max_by{|id, tackles| tackles}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[most_tackles]
  end

  def fewest_tackles(target_season)
    games = @games.to_a.select do |game|
              game[1] == target_season
            end
    game_ids = games.map do |game|
                game[0]
               end
    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end
    id_tackles = Hash.new(0)
    game_teams.each do |game|
      id_tackles[game[:team_id]] += game[:tackles].to_i
    end

    fewest_tackles = id_tackles.max_by{|id, tackles| -tackles}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[fewest_tackles]
  end

  def find_peter_laviolette(target_season)
    here_he_is = @game_teams.select{|game| game[:head_coach] == "Peter Laviolette"}
    game_ids = here_he_is.map{|game| game[:game_id]}
    puts game_ids
  end

end
