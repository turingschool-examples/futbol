require "./lib/stat_tracker"
require 'erb'

class PageGenerator
  attr_reader :stat_tracker, :template
  def initialize(locations)
    @stat_tracker = StatTracker.from_csv(locations)
    # @home_template = File.open('template.html', 'rb', &:read)
    # @game_template = File.open('template.html', 'rb', &:read)
  end

  def render(template_name)
    ERB.new(template_name).result(binding)
  end
end

home_template = File.open('./templates/home_template.html', 'rb', &:read)
game_template = File.open('./templates/game_template.html', 'rb', &:read)
league_template = File.open('./templates/league_template.html', 'rb', &:read)
season_template = File.open('./templates/season_template.html', 'rb', &:read)
team_template = File.open('./templates/team_template.html', 'rb', &:read)


game_path       = './data/games.csv'
team_path       = './data/teams.csv'
game_teams_path = './data/game_teams.csv'
locations = {
  games:      game_path,
  teams:      team_path,
  game_teams: game_teams_path
  }
home_generator = PageGenerator.new(locations).render(home_template)
game_generator = PageGenerator.new(locations).render(game_template)
league_generator = PageGenerator.new(locations).render(league_template)
season_generator = PageGenerator.new(locations).render(season_template)
team_generator = PageGenerator.new(locations).render(team_template)

File.write("./webpage/index.html", home_generator)
File.write("./webpage/game.html", game_generator)
File.write("./webpage/league.html", league_generator)
File.write("./webpage/season.html", season_generator)
File.write("./webpage/team.html", team_generator)
