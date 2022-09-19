require "rspec"
require './lib/stat_tracker'
require "./lib/team"

RSpec.describe StatTracker do
  let(:stat_tracker) {StatTracker.new}
  dummy_filepath = {teams: "./data/teams.csv",
                    games: './data/games_dummy1.2.csv',
                    game_teams: './data/game_teams_dummy1.csv'

  }
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
    expect(stat_tracker1.teams_reader[0][:team_id]).to eq("1")
    expect(stat_tracker1.teams_reader[0][:franchiseid]).to eq("23")
    expect(stat_tracker1.teams_reader[4][:link]).to eq("/api/v1/teams/6")
  end

  it "#average_goals_per_game returns the average number of goals scored in a
  game across all seasons including both home and away goals (rounded to the
  nearest 100th)" do
    expect(stat_tracker1.average_goals_per_game).to eq(4.43)
  end

  it "#average_goals_by_season returns the average number of goals scored in a
  game organized in a hash with season names as keys and a float representing
  the average number of goals in a game for that season as values" do
    result = {
      '20122013' => 3.00,
      '20162017' => 6.50,
      '20152016' => 4.50,
      '20132014' => 3.00
    }
    expect(stat_tracker1.average_goals_by_season).to eq(result)
  end

  it "#best_offense name of the team with the highest average number of goals
  scored per game across all seasons." do
    expect(stat_tracker1.best_offense).to eq("Toronto FC")
  end

  it "#total_goals_by_team returns a hash with team_id as the key, and total
  goals at away or home depending on the argument passed" do
    result = {"6"=>4.0, "3"=>6.0, "5"=>5.0, "30"=> 1.0, "24"=>6.0, "20"=>7.0,
      "21"=>2.0}
    expect(stat_tracker1.total_goals_by_team).to eq(result)
  end

  it "#team_name_from_id returns team name from ID passed as argument." do
    expect(stat_tracker1.team_name_from_id('20')).to eq('Toronto FC')
  end

  it "#worst_offense name of the team with the lowest average number of goals
  scored per game across all seasons." do
    expect(stat_tracker1.worst_offense).to eq('Orlando City SC')
  end

  it "#highest_scoring_home_team returns name of the team with the highest
  average score per game across all seasons when they are home." do
    expect(stat_tracker1.highest_scoring_home_team).to eq('Real Salt Lake')
  end

  it "#lowest_scoring_home_team returns name of the team with the lowest
  average score per game across all seasons when they are home." do
    expect(stat_tracker1.lowest_scoring_home_team).to eq('Toronto FC')
  end

  it "#total_goals_by_team_by_at returns hash with each team as a key
  and total goals for the argument passed as values" do
    home = {'6' => 4.0, '24' => 3.0, '20' => 0.0, '5' => 5.0, '21' => 2.0}
    expect(stat_tracker1.total_goals_by_team_by_at(:home_team_id)).to eq(home)

    away = {'3' => 6.0, '5' => 0.0, '20' => 7.0, '24' => 3.0, '30' => 1.0}
    expect(stat_tracker1.total_goals_by_team_by_at(:away_team_id)).to eq(away)
  end

  it "#highest_scoring_visitor returns name of the team with the highest
  average score per game across all seasons when they are away." do
    expect(stat_tracker1.highest_scoring_visitor).to eq('Toronto FC')
  end

  it "#lowest_scoring_visitor returns name of the team with the lowest
  average score per game across all seasons when they are away." do
    expect(stat_tracker1.lowest_scoring_visitor).to eq('Sporting Kansas City')
  end

  it '#most_tackles name of the Team with the most tackles in the season' do

    expect(stat_tracker1.most_tackles('20122013')).to eq('Philadelphia Union')
  end

  it '#fewest_tackles name of the Team with the fewest tackles in the season' do

    expect(stat_tracker1.fewest_tackles('20122013')).to eq('New England Revolution')
  end

  it "4. #count_of_teams" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
    games: './data/games_dummy_2.csv',
    game_teams: './data/game_teams.csv'
    }

    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.count_of_teams).to eq(5)
  end

  it "#. calculates without duplicates total goals in a game across all games" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams.csv'
    }

    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.unique_total_goals).to be_a(Array)
    #we'll test the third element, which should have 1 home goal and 2 away goals
    expect(stat_tracker.unique_total_goals[2]).to eq(4)
    expect(stat_tracker.unique_total_goals.length).to eq(4)
  end



  it "#. highest_total_score" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams.csv'

    }
    stat_tracker= StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.highest_total_score).to eq(5)
  end

  it "#. lowest_total_score" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams.csv'

    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.lowest_total_score).to eq(1)
  end

  it "#. total_number_of_games" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.total_number_of_games).to eq(10)
  end

  it "#. percentage_home_wins" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.percentage_home_wins).to eq(0.30)
  end

  it "#. percentage_visitor_wins" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.percentage_visitor_wins).to eq(0.20)
  end

  it "#. percentage_ties" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.percentage_ties).to eq(0.10)
  end

  it "#. team_finder" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.team_finder("4")).to eq(stat_tracker.teams_reader[1])
    expect(stat_tracker.team_finder("6")).to eq(stat_tracker.teams_reader[4])
    expect(stat_tracker.team_finder("4")[0]).to eq("4")
  end

  it "#. team_info" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.team_info("1")).to eq({"team_id" => "1",
                                                   "franchise_id" => "23",
                                                   "team_name" => "Atlanta United",
                                                   "abbreviation" => "ATL",
                                                   "link" => "/api/v1/teams/1"
    })
  end

  it "#. average_win_percentage" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.average_win_percentage("6")).to eq(1.00)
  end

  it "#. count_of_games_by_season" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.count_of_games_by_season).to eq({"20112012" => 2, "20122013" => 6, "20132014" => 2})
  end

  it "#. most_goals_scored" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.most_goals_scored("3")).to eq(2)
  end

  it "#. fewest_goals_scored" do
    dummy_filepath = {teams: "./data/team_dummy.csv",
                      games: './data/games_dummy_2.csv',
                      game_teams: './data/game_teams_dumdum.csv'
    }
    stat_tracker = StatTracker.from_csv(dummy_filepath)
    expect(stat_tracker.fewest_goals_scored("6")).to eq(2)
  end

    it "#. coach_results" do
      dummy_filepath = {teams: "./data/team_dummy.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_dumdum.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.coach_results("WIN", "20122013")).to eq({"John Tortorella"=>0, "Claude Julien"=>5, "Paul MacLean"=>0, "Michel Therrien"=>0})
    end

    it "#. games_by_head_coach" do
      dummy_filepath = {teams: "./data/team_dummy.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_dumdum.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.games_by_head_coach("20122013")).to eq({"John Tortorella"=>5, "Claude Julien"=>5, "Paul MacLean"=>1, "Michel Therrien"=>1})
    end

    it "#. winningest_coach" do
      	# Name of the Coach with the best win percentage for the season (string)
      dummy_filepath = {teams: "./data/team_dummy.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_3.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
    end

    it "#. games_by_team_by_result" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_3.csv',
                        game_teams: './data/game_teams_dumdum_2.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      result = {"8" => 1}
      expect(stat_tracker.games_by_team_by_result("3", "WIN")).to eq(result)
      result = {"6" => 5}
      expect(stat_tracker.games_by_team_by_result("3", "LOSS")).to eq(result)
    end

    it "#. games_totals_by_team for team" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_3.csv',
                        game_teams: './data/game_teams_dumdum_2.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.game_totals_by_team("3")).to eq({"6" => 5, "8" => 1})
    end

    it "#. all_games_by_team" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_3.csv',
                        game_teams: './data/game_teams_dumdum_2.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.all_games_by_team("3")).to include(stat_tracker.game_teams_reader[0], stat_tracker.game_teams_reader[2], stat_tracker.game_teams_reader[5], stat_tracker.game_teams_reader[7], stat_tracker.game_teams_reader[8], stat_tracker.game_teams_reader[10])
    end

    it "#. team_all_game_ids" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_3.csv',
                        game_teams: './data/game_teams_dumdum_2.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.team_all_game_ids("3")).to eq(["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030121"])
    end

    it "#. favorite_opponent" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_3.csv',
                        game_teams: './data/game_teams_dumdum_2.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)

      expect(stat_tracker.favorite_opponent("3")).to eq("New York Red Bulls")
    end

    it "#. rival" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_3.csv',
                        game_teams: './data/game_teams_dumdum_2.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.rival("3")).to eq("FC Dallas")
    end

    #Below is Rich's code for a parallel attempt on a helper method and favorite_opponent. We added to retain in case it works better with our I3 structure/Framework.

    # it "#. w_l_by_team" do
    #   dummy_filepath = {teams: "./data/teams.csv",
    #                     games: './data/games_dummy_2.csv',
    #                     game_teams: './data/game_teams_dumdum_rk.csv'
    #   }

    #   result = {'8' => 1}
    #   stat_tracker = StatTracker.from_csv(dummy_filepath)
    #   expect(stat_tracker.w_l_by_team("3", 'WIN')).to eq(result)
    # end

    # it "#favorite_opponent" do
    #   dummy_filepath = {teams: "./data/teams.csv",
    #                     games: './data/games_dummy_2_rk.csv',
    #                     game_teams: './data/game_teams_dumdum_rk.csv'
    #   }

    #   result = {'8' => 1}
    #   stat_tracker = StatTracker.from_csv(dummy_filepath)
    #   expect(stat_tracker.favorite_opponent('3')).to eq('New York Red Bulls')
    #   expect(stat_tracker.favorite_opponent('6')).to eq('Houston Dynamo')
    # end

    #coach results

    #games by head coach

    it "#. winningest_coach" do
        # Name of the Coach with the best win percentage for the season (string)
      dummy_filepath = {teams: "./data/team_dummy.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_3.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
    end

    it "#. worst_coach" do
        # Name of the Coach with the worst win percentage for the season (string)
      dummy_filepath = {teams: "./data/team_dummy.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_3.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
    end



    it "# best_season: season with the hightest win percentage for a team" do
      dummy_filepath = {teams: "./data/team_dummy.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_dumdum.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.best_season("6")).to eq("20112012").or eq('20122013') #also has 100% for "20122013" as well
    end

    it "# worst_season: season with the lowest win percentage for a team" do
      dummy_filepath = {teams: "./data/team_dummy.csv",
        games: './data/games_dummy_2.csv',
        game_teams: './data/game_teams_dumdum.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker.worst_season("3")).to eq("20112012") #team "17" also has 100% loss  for "20132014" as well
    end


    it "#most_accurate_team returns the name of the Team with the best ratio
    of shots to goals for the season" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_dummy1.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker1.most_accurate_team('20122013')).to eq('New York Red Bulls')
    end

    it "#least_accurate_team returns the name of the Team with the best ratio
    of shots to goals for the season" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_dummy1.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      expect(stat_tracker1.least_accurate_team('20122013')).to eq('New York City FC')
    end

    it "#total_goals_by_team_season returns hash of teams as keys and values
    of goals for the season" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_dummy1.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      result = {"6"=>3, "3"=>2, "5"=>1, "17"=>3, "16"=>2, "9"=>1, "8"=>3, "19"=>3}
      expect(stat_tracker1.total_goals_by_team_season('20122013')).to eq(result)
    end

    it "#total_shots_by_team_season returns hash of teams as keys and values
    of shots for the season" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_dummy1.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      result = {"6"=>12.0,
               "3"=>8.0,
               "5"=>6.0,
               "17"=>12.0,
               "16"=>10.0,
               "9"=>7.0,
               "8"=>8.0,
               "19"=>14.0}
      expect(stat_tracker1.total_shots_by_team_season('20122013')).to eq(result)
    end

    it "#accuracy_by_team_season returns hash of teams as keys and values
    of goals / shots for the season" do
      dummy_filepath = {teams: "./data/teams.csv",
                        games: './data/games_dummy_2.csv',
                        game_teams: './data/game_teams_dummy1.csv'
      }
      stat_tracker = StatTracker.from_csv(dummy_filepath)
      result = {"6"=> 3/12.0,
               "3"=> 2/8.0,
               "5"=> 1/6.0,
               "17"=> 3/12.0,
               "16"=> 2/10.0,
               "9"=> 1/7.0,
               "8"=> 3/8.0,
               "19"=> 3/14.0}
      expect(stat_tracker1.accuracy_by_team_season('20122013')).to eq(result)
    end
  end
