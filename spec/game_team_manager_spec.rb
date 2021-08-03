require 'spec_helper'

RSpec.describe GameTeamManager do
  before(:each) do
    game_path = './data/season_game_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/season_game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @game_team_manager = GameTeamManager.new(locations)
    @season_game_ids = ['2012030221', '2012030222', '2012030223', '2012030224', '2012030225',
      '2012030311', '2012030312', '2012030313', '2012030314', '2012030231']
    @season_team_ids = ['3', '6', '5', '17', '16']
  end

  it "exists" do
    expect(@game_team_manager).to be_a(GameTeamManager)
  end

  it "is an array" do
    expect(@game_team_manager.game_teams).to be_an(Array)
  end

  it 'can find by game id' do
    expect(@game_team_manager.by_game_id('2012030221')).to be_an(Array)
    expect(@game_team_manager.by_game_id('2012030221').count).to eq(2)
    expect(@game_team_manager.by_game_id('2012030221')[0]).to be_a(GameTeam)
  end

  it 'tied?' do
    expect(@game_team_manager.tied?('2012030221')).to eq(false)
    expect(@game_team_manager.tied?('2013030152')).to eq(true)
  end

  it 'has coaches' do
    results = ["John Tortorella", "Claude Julien", "John Tortorella", "Claude Julien",
      "Claude Julien", "John Tortorella", "Claude Julien", "John Tortorella",
      "John Tortorella", "Claude Julien", "Claude Julien", "Dan Bylsma", "Claude Julien",
      "Dan Bylsma", "Dan Bylsma", "Claude Julien", "Dan Bylsma", "Claude Julien", "Mike Babcock", "Joel Quenneville"]

    expect(@game_team_manager.coaches(@season_game_ids)).to eq(results)
  end

  it 'can find winning coach' do
    expect(@game_team_manager.winning_coach('2012030221')).to eq('Claude Julien')
  end

  xit 'can find winning coaches' do
    results = ["Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien",
      "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Joel Quenneville"]

    expect(@game_team_manager.winning_coaches(@season_game_ids)).to eq(results)
  end

  xit 'has results for each coach in a season' do
    results = {"Claude Julien"=>9,
               "Dan Bylsma"=>0,
               "Joel Quenneville"=>1,
               "John Tortorella"=>0,
               "Mike Babcock"=>0
              }
    expect(@game_team_manager.coach_wins(@season_game_ids)).to eq(results)
  end

  xit 'has winningest_coach by season' do
    expect(@game_team_manager.winningest_coach(@season_game_ids)).to eq("Claude Julien")
  end

  xit 'has worst coach by season' do
    expect(@game_team_manager.worst_coach(@season_game_ids)).to eq("John Tortorella")
  end

  it 'returns game teams by team id' do
    expect(@game_team_manager.by_team_id('3')).to be_an(Array)
    expect(@game_team_manager.by_team_id('3').count).to eq(5)
    expect(@game_team_manager.by_team_id('3')[0]).to be_a(GameTeam)
  end

  it 'has total shots by team id' do
    expect(@game_team_manager.total_shots('3')).to eq(38)
  end

  it 'has total goals by team id' do
    expect(@game_team_manager.total_goals('3')).to eq(8)
  end

  it 'has accuracy for each team' do
    results = {"16"=>5.0,
               "17"=>5.0,
               "3"=>4.75,
               "5"=>16.0,
               "6"=>3.17
              }
    expect(@game_team_manager.team_accuracy(@season_team_ids)).to eq(results)
  end

  it 'has most accurate team id' do
    expect(@game_team_manager.most_accurate_team(@season_team_ids)).to eq('6')
  end

  it 'has least accurate team_id' do
    expect(@game_team_manager.least_accurate_team(@season_team_ids)).to eq('5')
  end

  it 'has team tackles' do
    expect(@game_team_manager.team_tackles('3')).to eq(179)
  end

  it 'has team with most tackles' do
    expect(@game_team_manager.most_tackles(@season_team_ids)).to eq('6')
  end

  it 'has team with least tackles' do
    expect(@game_team_manager.fewest_tackles(@season_team_ids)).to eq('16')
  end

  it "creates a hash of teams and goals" do
    results = {
      "16"=>[2],
      "17"=>[1],
      "21"=> [2],
      "3"=>[2, 2, 1, 2, 1],
      "30"=> [2],
      "5"=>[0, 1, 1, 0],
      "6"=>[3, 3, 2, 3, 3, 3, 4, 2, 1]
    }
    expect(@game_team_manager.goals_by_team).to eq(results)
  end

  it "returns the average all time goals per game by team" do
    results = {
      "16"=>2.0,
      "17"=>1.0,
      "21"=> 2.0,
      "3"=>1.6,
      "30"=> 2.0,
      "5"=>0.5,
      "6"=>2.66
    }
    expect(@game_team_manager.average_goals).to eq(results)
  end

  it "returns the team id of team with the highest average goals per game" do
    expect(@game_team_manager.best_average_score_team).to eq("6")
  end

  it "returns the team id of team with the lowest average goals per game" do
    expect(@game_team_manager.worst_average_score_team).to eq("5")
  end
end
