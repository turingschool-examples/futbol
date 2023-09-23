require './spec/spec_helper'

class SingleSeasonData < AllSeasonData
  attr_reader   :name
  attr_accessor :coaches,
                :game_objects,
                :team_seasons
  def initialize(stat_tracker, season)
    super(stat_tracker)
    @season = season
    @coaches = []
    @game_objects = []
    @team_seasons = []
  end

  def initialize2
    coach_sorter
    team_season_object_grabber
    coach_win_counter
  end

  def coach_sorter
    coaches_names = @game_objects.map { |game| game.coach}.uniq
    coaches_names.each { |coach_name| @coaches << Coach.new(coach_name) }
  end

  def coach_win_counter
    @game_objects.each do |game| 
      coach_object = @coaches.find { |coach| game.coach == coach.name }
      coach_object.games += 1
      coach_object.wins += 1 if game.win?
    end
  end

  def team_season_object_grabber
    @stat_tracker.teams.each do |team|
      @team_seasons << team.seasons[@season]
    end
  end

end