<<<<<<< HEAD
task default: %w[test]

task :test do
  ruby "test/unittest.rb"
end
=======
require 'rake/testtask'

Rake::TestTask.new do |t|
    t.pattern = "test/**/*_test.rb"
end

task default: ["test"]
>>>>>>> 7aac971e7c1ad37e3e86c110fb2b3fc4dc0f2748
