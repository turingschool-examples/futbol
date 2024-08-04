require_relative './spec_helper'

RSpec.configure do |config| 
    config.formatter = :documentation 
end

RSpec.describe StatTracker do
    it 'exists' do
        stat_tracker = StatTracker.new
        expect(stat_tracker).to be_a StatTracker
    end

    before(:each) do
        game_path = './data/games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'

        @locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
        }
    end

    describe 'Class#from_csv' do
        it 'loads the files from the locations' do
            stat_tracker = StatTracker.from_csv(@locations)
            expect(stat_tracker.games).not_to be_empty
            expect(stat_tracker.teams).not_to be_empty
            expect(stat_tracker.game_teams).not_to be_empty
        end
    end

    describe 'Class#game_factory' do
        it 'creates a game object from a row' do
            game_tracker = StatTracker.game_factory(@locations)

            expect(game_tracker).to include Game
        end

        it 'creates a game object with all attributes' do
            game_tracker = StatTracker.game_factory(@locations)
            
            expect(game_tracker[0].game_id).to eq "2012030221"
            expect(game_tracker[0].season).to eq "20122013"
            expect(game_tracker[0].type).to eq "Postseason"
            expect(game_tracker[0].away_team_id).to eq "3"
            expect(game_tracker[0].home_team_id).to eq "6"
            expect(game_tracker[0].away_goals).to eq 2
            expect(game_tracker[0].home_goals).to eq 3
        end
    end

    describe 'Class#team_factory' do
        it 'creates a team object from a row' do
            team_tracker = StatTracker.team_factory(@locations)

            expect(team_tracker).to include Team
        end

        it 'creates a team object with all variables filled' do
            team_tracker = StatTracker.team_factory(@locations)

            expect(team_tracker[0].team_id).to eq "1"
            expect(team_tracker[0].franchise_id).to eq "23"
            expect(team_tracker[0].team_name).to eq "Atlanta United"
            expect(team_tracker[0].abbreviation).to eq "ATL"
        end
    end

    describe 'Class#game_teams_factory' do
        it 'creates a game_teams object from a row' do
            game_teams_tracker = StatTracker.game_team_factory(@locations)

            expect(game_teams_tracker).to include GameTeam
        end

        it 'creates a game_teams object with all variables filled' do
            game_teams_tracker = StatTracker.game_team_factory(@locations)
            expect(game_teams_tracker[0].game_id).to eq "2012030221"
            expect(game_teams_tracker[0].team_id).to eq "3"
            expect(game_teams_tracker[0].hoa).to eq "away"
            expect(game_teams_tracker[0].result).to eq "LOSS"
            expect(game_teams_tracker[0].head_coach).to eq "John Tortorella"
            expect(game_teams_tracker[0].goals).to eq 2
            expect(game_teams_tracker[0].shots).to eq 8
            expect(game_teams_tracker[0].tackles).to eq 44
        end
    end

    describe 'Statistics' do
        before(:all) do
            game_path = './data/games.csv'
            team_path = './data/teams.csv'
            game_teams_path = './data/game_teams.csv'
    
            @locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
            }
            @stat_tracker = StatTracker.from_csv(@locations)
        end

        describe 'Module#LeagueStatistics' do
            describe '#count_of_teams' do
                it 'can count the number of teams in the data' do
                    expect(@stat_tracker.count_of_teams).to be_an Integer
                    expect(@stat_tracker.count_of_teams).to eq 32  
                end
            end

            describe '#best_offense' do
                it 'returns the best offense' do
                    expect(@stat_tracker.best_offense).to be_a String
                    expect(@stat_tracker.best_offense).to eq("Reign FC")
                end
            end

            describe '#worst_offense' do
                it 'returns the worst offense' do
                    expect(@stat_tracker.worst_offense).to be_a String
                    expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
                end
            end

            describe '#highest_scoring_visitor' do
                it 'returns highest scoring visitor' do
                    expect(@stat_tracker.highest_scoring_visitor).to be_a String  
                    expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas" 
                end
            end

            describe '#highest_scoring_home_team' do
                it 'returns highest scoring home team' do
                    expect(@stat_tracker.highest_scoring_home_team).to be_a String  
                    expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
                end
            end

            describe '#lowest_scoring_visitor' do
                it 'returns lowest scoring visitor' do
                    expect(@stat_tracker.lowest_scoring_visitor).to be_a String  
                    expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
                end
            end

            describe '#lowest_scoring_home_team' do
                it 'returns lowest scoring home team' do
                    expect(@stat_tracker.lowest_scoring_home_team).to be_a String  
                    expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
                end
            end

            describe 'helper#home_away_goals_and_games' do
                it 'retrns a string of highest home team_id' do
                    expect(@stat_tracker.home_away_goals_and_games("home", "highest")).to eq("54")
                end

                it 'retrns a string of lowest home team_id' do
                    expect(@stat_tracker.home_away_goals_and_games("home", "lowest")).to eq("7")
                end

                it 'retrns a string of highest away team_id' do
                    expect(@stat_tracker.home_away_goals_and_games("away", "highest")).to eq("6")
                end

                it 'retrns a string of lowest away team_id' do
                    expect(@stat_tracker.home_away_goals_and_games("away", "lowest")).to eq("27")
                end
            end

            describe 'helper#team_goals_and_games' do
                it 'creates a hash with team_id as key and a hash of goals and games' do
                    expected = {
                        "1" => {:games=>463, :goals=>896},
                        "10" => {:games=>478, :goals=>1007},
                        "12" => {:games=>458, :goals=>936},
                        "13" => {:games=>464, :goals=>955},
                        "14" => {:games=>522, :goals=>1159},
                        "15" => {:games=>528, :goals=>1168},
                        "16" => {:games=>534, :goals=>1156},
                        "17" => {:games=>489, :goals=>1007},
                        "18" => {:games=>513, :goals=>1101},
                        "19" => {:games=>507, :goals=>1068},
                        "2" => {:games=>482, :goals=>1053},
                        "20" => {:games=>473, :goals=>978},
                        "21" => {:games=>471, :goals=>973},
                        "22" => {:games=>471, :goals=>964},
                        "23" => {:games=>468, :goals=>923},
                        "24" => {:games=>522, :goals=>1146},
                        "25" => {:games=>477, :goals=>1061},
                        "26" => {:games=>511, :goals=>1065},
                        "27" => {:games=>130, :goals=>263},
                        "28" => {:games=>516, :goals=>1128},
                        "29" => {:games=>475, :goals=>1029},
                        "3" => {:games=>531, :goals=>1129},
                        "30" => {:games=>502, :goals=>1062},
                        "4" => {:games=>477, :goals=>972},
                        "5" => {:games=>552, :goals=>1262},
                        "52" => {:games=>479, :goals=>1041},
                        "53" => {:games=>328, :goals=>620},
                        "54" => {:games=>102, :goals=>239},
                        "6" => {:games=>510, :goals=>1154},
                        "7" => {:games=>458, :goals=>841},
                        "8" => {:games=>498, :goals=>1019},
                        "9" => {:games=>493, :goals=>1038}
                    }
                    expect(@stat_tracker.team_goals_and_games(@stat_tracker.game_teams)).to eq(expected)
                end
            end

            describe 'helper#goals_per_game' do
                it 'transforms hash values into single value' do
                    teams = @stat_tracker.team_goals_and_games(@stat_tracker.game_teams)
                    expected = {
                        "1" => 1.9352051835853132,
                        "10" => 2.1066945606694563,
                        "12" => 2.0436681222707422,
                        "13" => 2.0581896551724137,
                        "14" => 2.2203065134099615,
                        "15" => 2.212121212121212,
                        "16" => 2.1647940074906367,
                        "17" => 2.0593047034764824,
                        "18" => 2.146198830409357,
                        "19" => 2.106508875739645,
                        "2" => 2.184647302904564,
                        "20" => 2.0676532769556024,
                        "21" => 2.0658174097664546,
                        "22" => 2.0467091295116773,
                        "23" => 1.9722222222222223,
                        "24" => 2.1954022988505746,
                        "25" => 2.2243186582809225,
                        "26" => 2.0841487279843443,
                        "27" => 2.023076923076923,
                        "28" => 2.186046511627907,
                        "29" => 2.166315789473684,
                        "3" => 2.1261770244821094,
                        "30" => 2.1155378486055776,
                        "4" => 2.0377358490566038,
                        "5" => 2.286231884057971,
                        "52" => 2.173277661795407,
                        "53" => 1.8902439024390243,
                        "54" => 2.343137254901961,
                        "6" => 2.2627450980392156,
                        "7" => 1.8362445414847162,
                        "8" => 2.0461847389558234,
                        "9" => 2.105476673427992
                    }
                    expect(@stat_tracker.goals_per_game(teams)).to eq(expected)
                end
            end
        end

        describe 'Module#GameStatistics' do

            describe '#highest_total_score' do
                it 'returns the highest total score' do
                    expect(@stat_tracker.highest_total_score).to be_a Integer
                    expect(@stat_tracker.highest_total_score).to eq 11
                end
            end

            describe '#lowest_total_score' do
                it 'returns the lowest total score' do
                    @stat_tracker.lowest_total_score

                    expect(@stat_tracker.lowest_total_score).to be_a Integer
                    expect(@stat_tracker.lowest_total_score).to eq 0
                end
            end

            describe '#percentage_home_wins' do
                it 'calculates a percentage of home wins' do
                    expect(@stat_tracker.percentage_home_wins).to be_a Float
                    expect(@stat_tracker.percentage_home_wins).to eq 0.44
                end
            end

            describe '#percentage_visitor_wins' do
                it 'calculates a percentage of visitor wins' do
                    expect(@stat_tracker.percentage_visitor_wins).to be_a Float
                    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
                end
            end

            describe '#percentage_ties' do
                it 'calculates ties' do
                    expect(@stat_tracker.percentage_ties).to be_a Float

                    expect(@stat_tracker.percentage_ties).to eq 0.2
                end
            end

            describe '#count_of_games_by_season' do
                it 'counts the game by season(regular or post)' do
                    expected = {
                        "20122013" => 806,
                        "20132014" => 1323,
                        "20142015" => 1319,
                        "20152016" => 1321,
                        "20162017" => 1317,
                        "20172018" => 1355
                    }

                    expect(@stat_tracker.count_of_games_by_season).to be_a Hash
                    expect(@stat_tracker.count_of_games_by_season).to eq(expected)
                end
            end

            describe '#average_goals_per_game' do
                it 'calculates avg goals per game' do
                    expect(@stat_tracker.average_goals_per_game).to be_a Float
                    expect(@stat_tracker.average_goals_per_game).to eq 4.22
                end
            end

            describe '#total_goals_by_season' do 
                it 'calculates the total goals by season' do
                    expected = {
                        "20122013" => 3322,
                        "20132014" => 5547,
                        "20142015" => 5461,
                        "20152016" => 5499,
                        "20162017" => 5565,
                        "20172018" => 6019
                    }
                    expect(@stat_tracker.total_goals_by_season).to be_a Hash
                    expect(@stat_tracker.total_goals_by_season).to eq(expected)
                end

            end

            describe '#average_goals_by_season' do 
                it 'calculates the average goals by season' do
                    expected = {
                        "20122013" => 4.12,
                        "20132014" => 4.19,
                        "20142015" => 4.14,
                        "20152016" => 4.16,
                        "20162017" => 4.23,
                        "20172018" => 4.44
                    }
                    expect(@stat_tracker.average_goals_by_season).to be_a Hash
                    expect(@stat_tracker.average_goals_by_season).to eq(expected)
                end
            end
        end

        describe 'Module#SeasonStatistics' do
            describe 'helper#games_per_seasons' do
                it 'will return an array of strings' do
                    expect(@stat_tracker.games_per_season('20122013')).to be_an Array
                end

                it 'will have game id strings' do
                    expected = @stat_tracker.games_per_season('20122013')
                    
                    expect(expected[0]).to eq '2012030221'
                    expect(expected.last).to eq '2012020570'
                end
            end

            describe 'helper#coaches wins losses ties' do
                it 'will return a hash' do
                    games_per_season = @stat_tracker.games_per_season('20122013')

                    expect(@stat_tracker.coaches_wins_losses_ties(games_per_season)).to be_a Hash
                end

                it 'will add a coach to a hash' do
                    class_info = {
                        :game_id => "2012030221",
                        :team_id => "3",
                        :hoa => "away",
                        :result => "LOSS",
                        :settled_in => "OT",
                        :head_coach => "John Tortorella",
                        :goals => "2",
                        :shots => "8",
                        :tackles => "44",
                        :pim => "8",
                        :power_play_opportunities => "3",
                        :power_play_goals => "0",
                        :face_off_win_percentage => "44.8",
                        :giveaways => "17",
                        :takeaways => "7"
                    }

                    game_teams_data = GameTeam.new(class_info)
                    coaches = {}

                    expect(@stat_tracker.update_coaches(game_teams_data, coaches)).to eq({
                        "John Tortorella" => [0, 0]
                    })
                end

                it 'will update games for each coach' do
                    class_info = {
                        :game_id => "2012030221",
                        :team_id => "3",
                        :hoa => "away",
                        :result => "LOSS",
                        :settled_in => "OT",
                        :head_coach => "John Tortorella",
                        :goals => "2",
                        :shots => "8",
                        :tackles => "44",
                        :pim => "8",
                        :power_play_opportunities => "3",
                        :power_play_goals => "0",
                        :face_off_win_percentage => "44.8",
                        :giveaways => "17",
                        :takeaways => "7"
                    }

                    game_teams_data = GameTeam.new(class_info)
                    coaches = {}
                    @stat_tracker.update_coaches(game_teams_data, coaches)

                    expect(@stat_tracker.update_games(game_teams_data, coaches)).to eq({
                        "John Tortorella" => [0, 1]
                    })
                end
            end

            describe '#winningest_coach' do
                it 'determines the coach with best season' do
                    season = "20122013"

                    expect(@stat_tracker.winningest_coach(season)).to eq("Dan Lacroix")
                end
            end

            describe '#worst_coach' do
                it 'determines the coach with worst season' do
                    season = "20122013"

                    expect(@stat_tracker.worst_coach(season)).to eq("Martin Raymond")
                end
            end

            describe '#most_accurate_team' do
                it 'gets game_ids per season' do
                    expect(@stat_tracker.games_per_season("20122013")).to be_a Array
                end

                it 'will have game id strings' do
                    expected = @stat_tracker.games_per_season('20122013')
                    
                    expect(expected[0]).to eq '2012030221'
                    expect(expected.last).to eq '2012020570'
                end
            end

            describe 'helper#team_id_hash' do
                it 'returns a hash' do
                    game_1 = @stat_tracker.game_teams.find {|game| game.game_id == '2012030221'}
                    hash = {"3" => [0, 0]}
                    teams = {}

                    expect(@stat_tracker.team_id_hash(game_1, teams)).to eq hash
                end
            end

            describe 'helper#update_shots_goals' do
                it 'updates team_hash with goals and shots' do
                    game_1 = @stat_tracker.game_teams.find {|game| game.game_id == '2012030221'}
                    hash = {"3" => [0, 0]}
                    teams = {}
                    @stat_tracker.team_id_hash(game_1, teams)
                    expect(teams["3"]).to eq [0, 0]

                    expect(@stat_tracker.update_shots_goals(game_1, teams)).to eq({"3" => [2, 8]})
                end
            end

            describe 'helper#team_shot_goal' do
                it 'creates hash of team ids with tally of goals and shots' do
                    game_ids = ['2012030221', '2012030232']
                    hash = {
                        "3" => [2, 8],
                        "6" => [3, 12],
                        "17" => [2, 7],
                        "16" => [1, 5]
                    }

                    expect(@stat_tracker.team_shot_goal(game_ids)).to eq(hash)
                end

                it 'adds to the tally of goals and shots' do
                    game_ids = ['2012030221', '2012030232', '2012030222']
                    hash = {
                        "3" => [4, 17],
                        "6" => [6, 20],
                        "17" => [2, 7],
                        "16" => [1, 5]
                    }

                    expect(@stat_tracker.team_shot_goal(game_ids)).to eq(hash)
                end
            end

            describe 'helper#get_team_name' do
                it 'takes team_id and returns name' do
                    expect(@stat_tracker.get_team_name("12")).to eq "Sky Blue FC"
                end
            end

            describe '#most_accurate_team' do
                it 'returns the team name of most_accurate_team' do
                    season = '20122013'

                    expect(@stat_tracker.most_accurate_team(season)).to eq "DC United"
                end
            end

            describe '#least_accurate_team' do
                it 'returns the team name of least_accurate_team' do
                    season = '20122013'

                    expect(@stat_tracker.least_accurate_team(season)).to eq "New York City FC"
                end
            end

            describe 'helper#team tackles' do
                it 'returns a hash with teams and tackles' do
                    game_ids = ['2012030221', '2012030232', '2012030222']
                        hash = {
                            "3" => 77,
                            "6" => 87,
                            "17" => 26,
                            "16" => 36                    
                        }
                    
                    expect(@stat_tracker.team_tackles(game_ids)).to eq hash
                end
            end

            describe 'helper#team id hashes' do
                it 'returns a hash' do
                    game_1 = @stat_tracker.game_teams.find {|game| game.game_id == '2012030221'}
                    hash = {"3" => 0}
                    teams = {}

                    expect(@stat_tracker.team_id_hashes(game_1, teams)).to eq hash
                end
            end

            describe 'helper#update tackles' do
                it 'updates team_id hashes with tackles' do
                    game_1 = @stat_tracker.game_teams.find {|game| game.game_id == '2012030221'}
                    hash = {"3" => 0}
                    teams = {}
                    @stat_tracker.team_id_hashes(game_1, teams)
                    expect(teams["3"]).to eq 0

                    expect(@stat_tracker.update_tackles(game_1, teams)).to eq({"3" => 44})
                end
            end

            describe '#most_tackles' do
                it 'returns the team with the most tackles' do
                    season = '20122013'

                    expect(@stat_tracker.most_tackles(season)).to eq "FC Cincinnati"
                end
            end

            describe '#fewest_tackles' do
                it 'returns the team with the most tackles' do
                    season = '20122013'

                    expect(@stat_tracker.fewest_tackles(season)).to eq "Atlanta United"
                end
            end
        end

        describe 'Module#TeamStatistics' do
            describe 'team_info' do
                it 'returns a hash' do
                    expect(@stat_tracker.team_info("4")).to be_a Hash
                end

                it 'has filled in values' do
                    team_info = {"team_name" => "Chicago Fire",
                    "team_id" => "4",
                    "franchise_id" => "16",
                    "abbreviation" => "CHI",
                    "link" => "/api/v1/teams/4" 
                    }

                    expect(@stat_tracker.team_info("4")).to eq(team_info)
                end
            end

            describe 'best_season' do
                it 'returns best_season for team' do
                    expect(@stat_tracker.best_season("4")).to eq "20132014"
                end

                it 'has helper#count_of_games_by_season_by_team return a hash' do
                    expected = {"20122013" => [15, 48],
                    "20132014" => [34, 89],
                    "20142015" => [27, 82],
                    "20152016" => [29, 88],
                    "20162017" => [24, 82],
                    "20172018" => [31, 88]
                    }

                    expect(@stat_tracker.count_of_games_by_season_by_team("4")).to be_a Hash
                    expect(@stat_tracker.count_of_games_by_season_by_team("4")).to eq expected
                end

                it 'has helper#update_seasons return a hash' do
                    game = @stat_tracker.games[2]
                    tracker = {}

                    expect(@stat_tracker.update_seasons(game, tracker)).to eq({"20122013" => [0, 0]})
                end

                it 'has helper#update_team_games return a hash' do
                    game = @stat_tracker.games[2]
                    tracker = {}
                    team_id = "6"
                    tracker = @stat_tracker.update_seasons(game, tracker)

                    expect(@stat_tracker.update_team_games(game, tracker, team_id)).to eq({"20122013" => [1, 1]})
                end
            end

            describe 'worst_season' do
                it 'returns worst season for team' do
                    expect(@stat_tracker.worst_season("4")).to eq "20162017"
                end
            end

            describe 'average_win_percentage' do
                it 'returns float of all wins over all games' do
                    expect(@stat_tracker.average_win_percentage("4")).to eq 0.33
                end
            end

            describe 'most_goals_scored' do
                it 'returns an integer of highest amount of goals scored' do
                    expect(@stat_tracker.most_goals_scored("4")).to eq 6
                end

                it 'has helper#game_check verify highest goal' do
                    expect(@stat_tracker.game_check(4, 2, 'high')).to eq 4
                    expect(@stat_tracker.game_check(2, 3, 'high')).to eq 3
                end
            end

            describe 'fewest_goals_scored' do
                it 'returns an integer of lowest amount of goals scored' do
                    expect(@stat_tracker.fewest_goals_scored("4")).to eq 0
                end

                it 'has helper#game_check verify lowest goal' do
                    expect(@stat_tracker.game_check(4, 2, 'low')).to eq 2
                    expect(@stat_tracker.game_check(2, 3, 'low')).to eq 2
                end
            end
        end
    end
end
