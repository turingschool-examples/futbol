require './lib/stat_tracker'

RSpec.describe StatTracker do

  before :each do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it '1. exists' do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it '3. can load an array of multiple CSVs' do
    expect(@stat_tracker.games).to be_a(CSV::Table)
    expect(@stat_tracker.teams).to be_a(CSV::Table)
    expect(@stat_tracker.game_teams).to be_a(CSV::Table)
  end
  describe 'League Methods' do
    xit 'can count teams' do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams_dummy.csv'
  
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
  
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.count_of_teams).to eq 32
    end

    xit 'can find best offense' do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams_dummy.csv'
  
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
  
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.best_offense).to eq "Name of the team with the highest average number of goals scored per game across all seasons."
    end

    xit 'can find worst offense' do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams_dummy.csv'
  
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
  
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.worst_offense).to eq "Name of the team with the lowest average number of goals scored per game across all seasons."
    end

    xit 'can find highest scoring visitor' do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams_dummy.csv'
  
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
  
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.highest_scoring_visitor).to eq "Name of the team with the highest average score per game across all seasons when they are away."
    end

    xit 'can find highest scoring home team' do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams_dummy.csv'
  
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
  
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.highest_scoring_home_team).to eq "Name of the team with the highest average score per game across all seasons when they are home."
    end

    xit 'can find lowest scoring visitor' do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams_dummy.csv'
  
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
  
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.lowest_scoring_visitor).to eq "Name of the team with the lowest average score per game across all seasons when they are a visitor."
    end

    xit 'can find lowest scoring home team' do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams_dummy.csv'
  
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
  
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.lowest_scoring_home_team).to eq "Name of the team with the lowest average score per game across all seasons when they are at home."
    end
  end
end
