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

        it 'creates a team object with all variables filled' do
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
        before(:each) do
            @stat_tracker = StatTracker.from_csv(@locations)
        end

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
                class_info = {:game_id => "2012030221",
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
                    :takeaways => "7"}

                game_teams_data = GameTeam.new(class_info)
                coaches = {}

                expect(@stat_tracker.update_coaches(game_teams_data, coaches)).to eq({
                    "John Tortorella" => [0, 0, 0]
                })
            end

            it 'will update games for each coach' do
                class_info = {:game_id => "2012030221",
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
                    :takeaways => "7"}

                game_teams_data = GameTeam.new(class_info)
                coaches = {}
                @stat_tracker.update_coaches(game_teams_data, coaches)

                expect(@stat_tracker.update_games(game_teams_data, coaches)).to eq({
                    "John Tortorella" => [0, 1, 0]
                })
            end
        end
        
        describe 'helper#percentage_of_wins' do
            it 'will return a percentage of wins per coach' do
                  coaches = {}
                  coaches = @stat_tracker.coaches_wins_losses_ties(["2012030231", "2012030232", "2012030162"])

                  expect(@stat_tracker.percentage_of_wins(coaches)).to eq({"Bruce Boudreau"=>0.0, "Joel Quenneville"=>50.0, "Mike Babcock"=>66.67})
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
        end

        describe '#least_accurate_team' do
        end

        describe '#most_tackles' do
        end

        describe '#fewest_tackles' do
        end
    end


end