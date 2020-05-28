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

  def winningest_coach(season_id)
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


end
