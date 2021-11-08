require 'CSV'
require './lib/stat_tracker'
require './lib/game_teams_manager'


RSpec.describe GameTeamsManager do
  it 'exists' do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)

    expect(game_teams_manager).to be_an_instance_of(GameTeamsManager)
  end

  it 'can create game objects' do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)

    expect(game_teams_manager.game_teams_objects[0]).to be_an(GameTeams)

    expect(game_teams_manager.game_teams_objects.count).to eq(14882)

  end

  it "calls method" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.average_goals_per_game_by_id(3)).to eq(2.13)
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
  #
  # it "calculates wins by team Id" do
  #   game_teams_path = './data/game_teams.csv'
  #   game_teams_manager = GameTeamsManager.new(game_teams_path)
  #   expect(game_teams_manager.wins_by_team_id(3)).to eq("Utah Royals FC")
  # end

  # it "test1" do
  #   game_teams_path = './data/game_teams.csv'
  #   game_teams_manager = GameTeamsManager.new(game_teams_path)
  #   expect(game_teams_manager.win_percent_by_id(7)).to eq(2.44)
  # end
  # it "test2" do
  #   game_teams_path = './data/game_teams.csv'
  #   game_teams_manager = GameTeamsManager.new(game_teams_path)
  #   expect(game_teams_manager.winning_coach).to eq("wade")
  # end
  # it "test3" do
  #   game_teams_path = './data/game_teams.csv'
  #   game_teams_manager = GameTeamsManager.new(game_teams_path)
  #   expect(game_teams_manager.losing_coach).to eq("wade")
  # end
  it "caluculates average win percentage" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.average_win_percentage(6)).to eq(0.49)
  end

  it "calculates tackles by team id" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.total_tackles_by_team_id(3)).to eq(13381)
  end



  it "calculates most tackles by season" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.most_tackles("season")).to eq("FC Cincinnati")
  end
end
