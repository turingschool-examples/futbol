require "rspec"
require './lib/stat_tracker'
require "./lib/team"

RSpec.describe StatTracker do
  let(:stat_tracker) {StatTracker.new}
  dummy_filepath = {teams: "./data/team_dummy.csv",
                    games: './data/games_dummy1.csv',
                    game_teams: './data/game_teams.csv'

  }
  # require "pry"; binding.pry
  let(:stat_tracker1) {StatTracker.from_csv(dummy_filepath)}

  it "1. exists" do
    expect(stat_tracker).to be_a(StatTracker)
  end

  it "2. has readable attributes" do
    expect(stat_tracker.teams_reader).to eq(nil)
    expect(stat_tracker.games_reader).to eq(nil)
    expect(stat_tracker.game_teams_reader).to eq(nil)
  end

  it "3. can parse CSV data" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy1.csv',
                      game_teams: './data/game_teams.csv'

    }
    stat_tracker_teams = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker_teams.teams_reader[0][:team_id]).to eq("1")
    expect(stat_tracker_teams.teams_reader[0][:franchiseid]).to eq("23")
    expect(stat_tracker_teams.teams_reader[4][:link]).to eq("/api/v1/teams/6")
  end

  it "#average_goals_per_game" do
    # dummy_filepath = {teams: "./data/team_dummy.csv",
    #                   games: './data/games_dummy1.csv',
    #                   game_teams: './data/game_teams.csv'
    # 
    # }
    # stat_tracker1 = StatTracker.from_csv(dummy_filepath)
    # require "pry"; binding.pry
    expect(stat_tracker1.average_goals_per_game).to eq(5.00)
  end

  it "#average_goals_by_season" do
    # dummy_filepath = {teams: "./data/team_dummy.csv",
    #                   games: './data/games_dummy1.csv',
    #                   game_teams: './data/game_teams.csv'
    # 
    # }
    # stat_tracker1 = StatTracker.from_csv(dummy_filepath)

    result = {
      '20122013' => 5.00,
      '20132014' => 5.00
    }
    expect(stat_tracker1.average_goals_by_season).to eq(result)
  end

  it '#best_offense Name of the team with the highest average number of goals
  scored per game across all seasons.' do
    dummy_filepath = {teams: "./data/teams.csv",
                      games: './data/games_dummy1.1.csv',
                      game_teams: './data/game_teams.csv'
    
    }
    stat_tracker1 = StatTracker.from_csv(dummy_filepath)

    expect(stat_tracker1.best_offense).to eq("Toronto FC")

  end

  it '#total_goals_by_team' do
    dummy_filepath = {teams: "./data/teams.csv",
                      games: './data/games_dummy1.1.csv',
                      game_teams: './data/game_teams.csv'

    }
    stat_tracker1 = StatTracker.from_csv(dummy_filepath)

    result = {"6"=>4.0, "3"=>6.0, "5"=>5.0, "30"=>0.0, "24"=>6.0, "20"=>9.0,
      "21"=>2.0}
    expect(stat_tracker1.total_goals_by_team).to eq(result)
  end

  it '#team_name_from_id' do
    dummy_filepath = {teams: "./data/teams.csv",
                      games: './data/games_dummy1.1.csv',
                      game_teams: './data/game_teams.csv'

    }
    stat_tracker1 = StatTracker.from_csv(dummy_filepath)

    expect(stat_tracker1.team_name_from_id('20')).to eq('Toronto FC')
  end
  
  it "#worst_offense Name of the team with the lowest average number of goals
  scored per game across all seasons." do
    dummy_filepath = {teams: "./data/teams.csv",
      games: './data/games_dummy1.1.csv',
      game_teams: './data/game_teams.csv'
      
    }
    stat_tracker1 = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker1.worst_offense).to eq('Orlando City SC')
  end
  
  it "#highest_scoring_home_team returns name of the team with the highest
  average score per game across all seasons when they are home." do
  dummy_filepath = {teams: "./data/teams.csv",
    games: './data/games_dummy1.2.csv',
    game_teams: './data/game_teams.csv'
    
  }
  stat_tracker1 = StatTracker.from_csv(dummy_filepath)
  
  expect(stat_tracker1.highest_scoring_home_team).to eq('Real Salt Lake')
  end
  
  it "#lowest_scoring_home_team returns name of the team with the lowest
  average score per game across all seasons when they are home." do
  dummy_filepath = {teams: "./data/teams.csv",
    games: './data/games_dummy1.2.csv',
    game_teams: './data/game_teams.csv'
    
  }
  stat_tracker1 = StatTracker.from_csv(dummy_filepath)
  
  expect(stat_tracker1.lowest_scoring_home_team).to eq('Toronto FC')
  end
  
  it "#total_goals_by_team_by_at returns hash with each team as a key
  and total goals for the argument passed as values" do
  dummy_filepath = {teams: "./data/teams.csv",
    games: './data/games_dummy1.2.csv',
    game_teams: './data/game_teams.csv'
    
  }
  stat_tracker1 = StatTracker.from_csv(dummy_filepath)
  
  home = {'6' => 4.0, '24' => 3.0, '20' => 0.0, '5' => 5.0, '21' => 2.0}
  expect(stat_tracker1.total_goals_by_team_by_at(:home_team_id)).to eq(home)
  
  away = {'3' => 6.0, '5' => 0.0, '20' => 7.0, '24' => 3.0, '30' => 1.0}
  expect(stat_tracker1.total_goals_by_team_by_at(:away_team_id)).to eq(away)
  
  end
  
  it "#highest_scoring_visitor returns name of the team with the highest
  average score per game across all seasons when they are away." do
  dummy_filepath = {teams: "./data/teams.csv",
    games: './data/games_dummy1.2.csv',
    game_teams: './data/game_teams.csv'
    
  }
  stat_tracker1 = StatTracker.from_csv(dummy_filepath)
  expect(stat_tracker1.highest_scoring_visitor).to eq('Toronto FC')
  end
  
  it "#lowest_scoring_visitor returns name of the team with the lowest
  average score per game across all seasons when they are away." do
  dummy_filepath = {teams: "./data/teams.csv",
    games: './data/games_dummy1.2.csv',
    game_teams: './data/game_teams.csv'
    
  }
  stat_tracker1 = StatTracker.from_csv(dummy_filepath)
  expect(stat_tracker1.lowest_scoring_visitor).to eq('Sporting Kansas City')
  end
end
