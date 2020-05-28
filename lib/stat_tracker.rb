class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]
  end

  def self.from_csv(data_files)
    StatTracker.new(data_files)
  end

  def game_collection
    GameCollection.new
  end

  def team_collection
    TeamCollection.new
  end

  def game_team_collection
    GameTeamCollection.new
  end

  def highest_total_score
    top_score = 0
    CSV.foreach(@games, headers: true, header_converters: :symbol) do |game|
      if game[:away_goals].to_i + game[:home_goals].to_i > top_score
        top_score = game[:away_goals].to_i + game[:home_goals].to_i
      end
    end
    top_score
  end

  def lowest_total_score
    lowest_score = 1_000_000_000
    CSV.foreach(@games, headers: true, header_converters: :symbol) do |game|
      if game[:away_goals].to_i + game[:home_goals].to_i < lowest_score
        lowest_score = game[:away_goals].to_i + game[:home_goals].to_i
      end
    end
    lowest_score
  end

  def winningest_coach(season_id) ## NOT WORKING ALWAYS RETURNS MIKE YEO
    coaches_stats = Hash.new(0)
    CSV.foreach(@games, headers: true, header_converters: :symbol) do |game|
      if game[:season].to_i == season_id
        CSV.foreach(@game_teams, headers: true, header_converters: :symbol) do |game_team|
          if game_team[:result] == "LOSS"
            coaches_stats[game_team[:head_coach]] -= 1
          else
            coaches_stats[game_team[:head_coach]] += 1
          end
        end
      end
    end
    best_coach = coaches_stats.max_by do |coach, wins|
      wins
    end
    best_coach[0]
  end

  def most_accurate_team(season_id)
    best_ratio = 0
    best_team = nil
    CSV.foreach(@game_teams, headers: true, header_converters: :symbol) do |game_team|
      if season_id.to_s.include?(game_team[:game_id].split(//).join[0..3])
        if game_team[:goals].to_f / game_team[:shots].to_f > best_ratio
          best_ratio = game_team[:goals].to_f / game_team[:shots].to_f
          best_team = game_team
        end
      end
    end

    team_name_based_off_of_team_id(best_team[:team_id].to_i)
  end

  def least_accurate_team(season_id)
    worst_ratio = 1.0
    worst_team = nil
    CSV.foreach(@game_teams, headers: true, header_converters: :symbol) do |game_team|
      if season_id.to_s.include?(game_team[:game_id].split(//).join[0..3])
        if game_team[:goals].to_f / game_team[:shots].to_f <= worst_ratio
          worst_ratio = game_team[:goals].to_f / game_team[:shots].to_f
          worst_team = game_team
        end
      end
    end

    team_name_based_off_of_team_id(worst_team[:team_id].to_i)
  end

  def team_name_based_off_of_team_id(team_id)
    CSV.foreach(@teams, headers: true, header_converters: :symbol) do |team|
      if team_id == team[:team_id].to_i
        return team[:teamname]
      end
    end
  end




end
