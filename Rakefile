#!/usr/bin/env rake

desc 'Runs foodcritic linter'
task :foodcritic do
  sh 'foodcritic --epic-fail any .'
end

desc 'Runs Rubocop linter'
task :rubocop do
  sh 'rubocop .'
end

desc 'Runs chefspec'
task :chefspec do
  sh 'rspec spec/'
end
