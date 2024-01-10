require './lib/team'
require './lib/team_factory'
require 'pry'

RSpec.describe TeamFactory do
    describe '#initialize' do
        before do
            @file_path = './data/teams_fixture.csv'
            @team_factory = TeamFactory.new(@file_path)
        end

        it 'exists' do

            expect(@team_factory).to be_a(TeamFactory)

        end

        it 'has a file path attribute' do

            expect(@team_factory.file_path).to eq(@file_path)

        end
    end
end

