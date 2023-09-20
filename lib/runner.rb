require 'simplecov'
require 'csv'
require 'pry-nav'
require './spec/spec_helper'


st = StatTracker.new

high = st.highest_total_score
p high

low = st.lowest_total_score
p low