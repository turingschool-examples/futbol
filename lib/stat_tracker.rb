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
    GameCollection.new(@games)
  end

  def team_collection
    TeamCollection.new(@teams)
  end

  def game_team_collection
    GameTeamCollection.new(@game_teams)
  end

  def highest_total_score
    total = game_collection.all.max_by do |game|
      game.away_goals + game.home_goals
    end
    total.home_goals + total.away_goals
  end

  def lowest_total_score
    total = game_collection.all.min_by do |game|
      game.away_goals + game.home_goals
    end
    total.home_goals + total.away_goals
  end

  def team_info(team_id)
    teams.all.reduce({}) do |acc, team|
      require "pry"; binding.pry
    end
    # acc = {}
    # CSV.foreach(@teams, headers: true, header_converters: :symbol) do |row|
    #   if row[:team_id].to_i == team_id
    #     row.delete(:stadium)
    #     acc = row.to_h
    #   end
    # end
    # acc
  end

  def best_season(team_id)
    acc = 0
    rows = CSV.read(@games, headers: true, header_converters: :symbol)
    filtered_rows = rows.find_all do |row|
      row[:home_team_id].to_i == team_id || row[:home_team_id].to_i == team_id
    end
  end

end
