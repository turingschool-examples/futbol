require 'spec_helper'
require './lib/stat_tracker'
require './lib/game_manager'
require './lib/game_teams_manager'
require './lib/game_teams'
require './lib/games'
require './lib/team_manager'
require './lib/teams'
RSpec.describe StatTracker do
  it 'exists' do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
              games: game_path,
              teams: team_path,
              game_teams: game_teams_path
                }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker).to be_an_instance_of(StatTracker)
  end

  it '#highest_total_score' do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
              games: game_path,
              teams: team_path,
              game_teams: game_teams_path
                }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker.highest_total_score).to eq(11)
  end

  it '#most_goals_scored' do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.most_goals_scored("18")).to eq(7)
    # expect(game_teams_manager.most_goals_scored.include?("3")).to eq(false)
  end

  it '#fewest_goals_scored' do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.most_goals_scored("18")).to eq(7)
    # expect(game_teams_manager.most_goals_scored.include?("3")).to eq(false)
  end

  it "caluculates average win percentage" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.average_win_percentage(6)).to eq(0.49)
  end

  it "calculates best offense" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.best_offense).to eq("Reign FC")
  end

  it "calculates worst offense" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.worst_offense).to eq("Utah Royals FC")
  end

  it "calculates highest scoring visitor" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.highest_scoring_visitor).to eq("FC Dallas")
  end

  it "calculates highest scoring home team" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.highest_scoring_home_team).to eq("Reign FC")
  end

  it "calculates lowest scoring visitor" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.lowest_scoring_visitor).to eq("San Jose Earthquakes")
  end

  it "calculates lowest scoring home team" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.lowest_scoring_home_team).to eq("Utah Royals FC")
  end

  it "caluculates average win percentage" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.average_win_percentage(3)).to eq(0.43)
  end

  it "calculates most tackles" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.most_tackles("20132014")).to eq("FC Cincinnati")
  end

  it "calculates fewest tackles" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.fewest_tackles(20132014)).to eq("Atlanta United")
  end

end
