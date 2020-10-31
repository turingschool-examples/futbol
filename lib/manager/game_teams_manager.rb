class GameTeamsManager
  attr_reader :location,
              :parent,
              :game_teams

  def self.get_data(location, parent)
    game_teams = []
    CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row, self)
    end

    new(location, parent, game_teams)
  end

  def initialize(location, parent, game_teams)
    @location = location
    @parent = parent
    @game_teams = game_teams
  end

  def winningest_coach(season)
    season = season.to_s
    coaches = coaches_by_season(season)
    coach_stats = get_stats(coaches, season)
    coach_win_percentage = calc_coach_percentage(coach_stats)
    winningest = coach_win_percentage.max_by do |coach, percent|
       percent
    end[0]
  end

  def calc_coach_percentage(coach_stats)
    percentages = {}
    coach_stats.each do |coach, stat|
      percentages[coach] = calc_percentage(stat[:wins], stat[:games])
    end

    percentages
  end

  def coaches_by_season(season)
    coaches = {}

    game_teams.each do |game_team|
      next if coaches.key?(game_team.head_coach) || verify_in_season(season, game_team.game_id)
      coaches[game_team.head_coach] = {:games => 0, :wins => 0}
    end

    coaches
  end

  # returns true or false
  def verify_in_season(season, id)
    season = season.to_s
    id = id.to_s
    # looks in games array in manager class
    parent.verify_in_season(season, id)
  end

  def get_stats(coaches, season)
    game_teams.each do |game_team|
      # next if verify_in_season(season, game_team.game_id) == false
      current_coach = game_team.head_coach
      require 'pry'; binding.pry
      coaches[current_coach][:games] += 1
      coaches[current_coach][:wins] += 1 if game_team.result == "WIN"
    end

    coaches
  end

  def calc_percentage(numerator, denominator)
    (numerator.to_f / denominator).round(2)
  end
end