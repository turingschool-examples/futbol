require 'rake/testtask'

Rake::TestTask.new do |t|
    #tells rake to test all files inside the test directory that end with _test.rb
    t.pattern = "test/**/*_test.rb"
end
  #specifies the task we're using rake for is testing
task default: ["test"]

#use rake by going to the terminal and running: rake
