# require_relative 'spec_helper'

RSpec.describe Season do
  before(:each) do
    @season = Season.new({season: 20122013})
  end

#   describe "#initialize" do
#     it 'creates a new instance of season class' do

#       expect(@season).to be_a Season
#     end

#     it 'has readable attributes' do

      expect(@season.season).to eq(20122013)
    end

    it ''
  end
end