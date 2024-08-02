require_relative './spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe StatTracker do
    xit 'exists' do
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
        xit 'loads the files from the locations' do
            stat_tracker = StatTracker.from_csv(@locations)
            expect(stat_tracker.games).not_to be_empty
            expect(stat_tracker.teams).not_to be_empty
            expect(stat_tracker.game_teams).not_to be_empty
        end
    end

    describe 'Class#game_factory' do
        xit 'creates a game object from a row' do
            game_tracker = StatTracker.game_factory(@locations)

            expect(game_tracker).to include Game
        end

        xit 'creates a game object with all attributes' do
            game_tracker = StatTracker.game_factory(@locations)
            
            expect(game_tracker[0].game_id).to eq "2012030221"
            expect(game_tracker[0].season).to eq "20122013"
            expect(game_tracker[0].type).to eq "Postseason"
            expect(game_tracker[0].date_time).to eq "5/16/13"
            expect(game_tracker[0].away_team_id).to eq "3"
            expect(game_tracker[0].home_team_id).to eq "6"
            expect(game_tracker[0].away_goals).to eq 2
            expect(game_tracker[0].home_goals).to eq 3
            expect(game_tracker[0].venue).to eq "Toyota Stadium"
            expect(game_tracker[0].venue_link).to eq "/api/v1/venues/null"
        end
    end

    describe 'Class#team_factory' do
        it 'creates a team object from a row' do
            team_tracker = StatTracker.team_factory(@locations)

            expect(team_tracker).to include Team
        end
# change back from dummy data and reinable the following test
        xit 'creates a team object with all variables filled' do
            team_tracker = StatTracker.team_factory(@locations)

            expect(team_tracker[0].team_id).to eq "1"
            expect(team_tracker[0].franchise_id).to eq "23"
            expect(team_tracker[0].team_name).to eq "Atlanta United"
            expect(team_tracker[0].abbreviation).to eq "ATL"
            expect(team_tracker[0].stadium).to eq "Mercedes-Benz Stadium"
            expect(team_tracker[0].link).to eq "/api/v1/teams/1"
        end
    end

    describe 'Class#game_teams_factory' do
        xit 'creates a game_teams object from a row' do
            game_teams_tracker = StatTracker.game_team_factory(@locations)

            expect(game_teams_tracker).to include GameTeam
        end

        xit 'creates a game_teams object with all variables filled' do
            game_teams_tracker = StatTracker.game_team_factory(@locations)
            expect(game_teams_tracker[0].game_id).to eq "2012030221"
            expect(game_teams_tracker[0].team_id).to eq "3"
            expect(game_teams_tracker[0].hoa).to eq "away"
            expect(game_teams_tracker[0].result).to eq "LOSS"
            expect(game_teams_tracker[0].settled_in).to eq "OT"
            expect(game_teams_tracker[0].head_coach).to eq "John Tortorella"
            expect(game_teams_tracker[0].goals).to eq 2
            expect(game_teams_tracker[0].shots).to eq 8
            expect(game_teams_tracker[0].tackles).to eq 44
            expect(game_teams_tracker[0].pim).to eq 8
            expect(game_teams_tracker[0].power_play_opportunities).to eq 3
            expect(game_teams_tracker[0].power_play_goals).to eq 0
            expect(game_teams_tracker[0].face_off_win_percentage).to eq 44.8
            expect(game_teams_tracker[0].giveaways).to eq 17
            expect(game_teams_tracker[0].takeaways).to eq 7
        end
    end

    describe 'Module#GameStatistics' do
        before(:each) do
            @stat_tracker = StatTracker.from_csv(@locations)
        end

        describe '#highest_total_score' do
            xit 'returns the highest total score' do

                expect(@stat_tracker.highest_total_score).to be_a Integer
                # expect(@stat_tracker.highest_total_score).to eq 5
                expect(@stat_tracker.highest_total_score).to eq 11 
            end
        end

        describe '#lowest_total_score' do
            xit 'returns the lowest total score' do
                @stat_tracker.lowest_total_score

                expect(@stat_tracker.lowest_total_score).to be_a Integer
                # expect(@stat_tracker.lowest_total_score).to eq 1
                expect(@stat_tracker.lowest_total_score).to eq 0 
            end
        end

        describe '#percentage_home_wins' do
            xit 'calculates a percentage of home wins' do

                expect(@stat_tracker.percentage_home_wins).to be_a Float
                # expect(@stat_tracker.percentage_home_wins).to eq 0.58
                expect(@stat_tracker.percentage_home_wins).to eq 0.44 
            end
        end

        describe '#percentage_visitor_wins' do
            xit 'calculates a percentage of visitor wins' do

                expect(@stat_tracker.percentage_visitor_wins).to be_a Float
                # expect(@stat_tracker.percentage_visitor_wins).to eq 0.42
                expect(@stat_tracker.percentage_visitor_wins).to eq 0.36 
            end

        end

        describe '#percentage_ties' do
            xit 'calculates ties' do

                expect(@stat_tracker.percentage_ties).to be_a Float
                # expect(@stat_tracker.percentage_ties).to eq 0.0
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
            xit 'calculates avg goals per game' do

                expect(@stat_tracker.average_goals_per_game).to be_a Float
                # expect(@stat_tracker.average_goals_per_game).to eq 3.67
                expect(@stat_tracker.average_goals_per_game).to eq 4.22
            end

        end

        describe '#average_goals_by_season' do 
            it 'calculates the average goals by season (regular or post)' do
                expected = {
                    "20122013" => 806,
                    "20132014" => 1323,
                    "20142015" => 1319,
                    "20152016" => 1321,
                    "20162017" => 1317,
                    "20172018" => 1355
                }
                expect(@stat_tracker.average_goals_by_season).to be_a Hash
                expect(@stat_tracker.average_goals_by_season).to eq(expected)
            end
        end
    end

    # describe 'Module#SeasonStatistics' do
    #     before(:each) do
    #         @stat_tracker = StatTracker.from_csv(@locations)
    #     end

    #     describe 'helper#games_per_seasons' do
    #         it 'will return an array of strings' do
    #             expect(@stat_tracker.games_per_season('20122013')).to be_an Array
    #         end

    #         it 'will have game id strings' do
    #             expected = @stat_tracker.games_per_season('20122013')
                
    #             expect(expected[0]).to eq '2012030221'
    #             expect(expected.last).to eq '2012020570'
    #         end
    #     end

    #     describe 'helper#coaches wins losses ties' do
    #         it 'will return a hash' do
    #             games_per_season = @stat_tracker.games_per_season('20122013')

    #             expect(@stat_tracker.coaches_wins_losses_ties(games_per_season)).to be_a Hash
    #         end

    #         it 'will add a coach to a hash' do
    #             class_info = {:game_id => "2012030221",
    #                 :team_id => "3",
    #                 :hoa => "away",
    #                 :result => "LOSS",
    #                 :settled_in => "OT",
    #                 :head_coach => "John Tortorella",
    #                 :goals => "2",
    #                 :shots => "8",
    #                 :tackles => "44",
    #                 :pim => "8",
    #                 :power_play_opportunities => "3",
    #                 :power_play_goals => "0",
    #                 :face_off_win_percentage => "44.8",
    #                 :giveaways => "17",
    #                 :takeaways => "7"}

    #             game_teams_data = GameTeam.new(class_info)
    #             coaches = {}

    #             expect(@stat_tracker.update_coaches(game_teams_data, coaches)).to eq({
    #                 "John Tortorella" => [0, 0, 0]
    #             })
    #         end

    #         it 'will update games for each coach' do
    #             class_info = {:game_id => "2012030221",
    #                 :team_id => "3",
    #                 :hoa => "away",
    #                 :result => "LOSS",
    #                 :settled_in => "OT",
    #                 :head_coach => "John Tortorella",
    #                 :goals => "2",
    #                 :shots => "8",
    #                 :tackles => "44",
    #                 :pim => "8",
    #                 :power_play_opportunities => "3",
    #                 :power_play_goals => "0",
    #                 :face_off_win_percentage => "44.8",
    #                 :giveaways => "17",
    #                 :takeaways => "7"}

    #             game_teams_data = GameTeam.new(class_info)
    #             coaches = {}
    #             @stat_tracker.update_coaches(game_teams_data, coaches)

    #             expect(@stat_tracker.update_games(game_teams_data, coaches)).to eq({
    #                 "John Tortorella" => [0, 1, 0]
    #             })
    #         end
    #     end
        
        describe 'helper#percentage_of_wins' do
            it 'will return a percentage of wins per coach' do
                coaches = {}
                coaches = @stat_tracker.coaches_wins_losses_ties(["2012030231", "2012030232", "2012030162"])

                expect(@stat_tracker.percentage_of_wins(coaches)).to eq({"Bruce Boudreau"=>0.0, "Joel Quenneville"=>50.0, "Mike Babcock"=>66.67})
            end
        end

    #     describe '#winningest_coach' do
    #         it 'determines the coach with best season' do
    #             season = "20122013"

    #             expect(@stat_tracker.winningest_coach(season)).to eq("Dan Lacroix")
    #         end
    #     end

    #     describe '#worst_coach' do
    #         it 'determines the coach with worst season' do
    #             season = "20122013"

    #             expect(@stat_tracker.worst_coach(season)).to eq("Martin Raymond")
    #         end
    #     end

        describe '#most_accurate_team' do
            it 'gets game_ids per season' do
                expect(@stat_tracker.games_per_season("20122013")).to be_a Array
            end

            it 'will have game id strings' do
                expected = @stat_tracker.games_per_season('20122013')
                
                expect(expected[0]).to eq '2012030221'
                expect(expected.last).to eq '2012020570'
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

            describe 'helper#goal_shot_ratio' do
                it 'converts array into ratio' do
                    game_ids = ['2012030221', '2012030232', '2012030222']
                    hash = {
                        "3" => 0.24,
                        "6" => 0.30,
                        "17" => 0.29,
                        "16" => 0.20
                    }
                    teams = @stat_tracker.team_shot_goal(game_ids)
                    
                    expect(@stat_tracker.goal_shot_ratio(teams)).to eq hash
                end
            end
            describe 'helper#get_team_name' do
                it 'takes team_id and returns name' do
                    expect(@stat_tracker.get_team_name("12")).to eq "Sky Blue FC"
                end
            end

            it 'returns the team name of most_accurate_team' do
                season = '20122013'

                expect(@stat_tracker.most_accurate_team(season)).to eq "DC United"
            end
        end

        describe '#least_accurate_team' do
            it 'returns the team name of least_accurate_team' do
                season = '20122013'

                expect(@stat_tracker.least_accurate_team(season)).to eq "Houston Dynamo"
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
        #rename later
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
end
## games per season
# team_tackles
# teams.max_by
# get team_name



# games per season
# modify team_shot_goal so that it is just team_tackles
# modify team_id_hash to be an integer instead of an array
# modify update_shot goal - to be modify tackles - find key and incriment value by however many tackles
# 
# modify most/least accurate
# teams max_by
# teams min_by
# no need for ratio method


# describe '#fewest_tackles' do
# games per season
# team_tackles
# teams.min_by
# get team_name
# end
