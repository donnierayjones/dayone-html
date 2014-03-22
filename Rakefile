task :launch do
  sleep 2
  %x{open 'http://localhost:4567'}
end

task :run do
  %x{bundle exec ruby dayone.html.rb}
end

multitask :run_and_launch => [:run, :launch]

task :default => :run_and_launch
