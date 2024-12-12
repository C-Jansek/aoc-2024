#!/usr/bin/env ruby
require 'fileutils'
require 'date'

# Get parameters from ARGV
day = ARGV[0] || Date.today.day.to_s.rjust(2, '0')
year = ARGV[1] || Date.today.year.to_s
challenge_name = ARGV[2] || 'challenge'

script_location = File.expand_path(File.dirname(__FILE__))

templates_directory = File.join(script_location, "templates")
solution_template = File.join(templates_directory, "template.rb")
test_template = File.join(templates_directory, "test.rb")

root_directory = File.expand_path(File.join(".."), script_location)
day_specific_directory = File.join("aoc", "year_#{year}", "day_#{day}")

solution_target = File.join(root_directory, "lib", day_specific_directory, "#{challenge_name}.rb")
input_target = File.join(root_directory, "lib", day_specific_directory, "input.txt")
test_target = File.join(root_directory, "test", day_specific_directory, "#{challenge_name}_test.rb")

begin
  solution_file = File.read(solution_template)
                      .gsub('DayDD', "Day#{day}")
                      .gsub('YearYYYY', "Year#{year}")

  FileUtils.mkdir_p(File.dirname(solution_target))

  if File.exist?(solution_target)
    puts "Solution file not created, #{solution_target} already exists."
  else
    File.write(solution_target, solution_file)
  end

  if File.exist?(input_target)
    puts "Input file not created, #{input_target} already exists."
  else
    File.write(input_target, '')
  end

  test_file = File.read(test_template)
                  .gsub('DayDD', "Day#{day}")
                  .gsub('YearYYYY', "Year#{year}")

  FileUtils.mkdir_p(File.dirname(test_target))

  if File.exist?(test_target)
    puts "Test file not created, #{test_target} already exists."
  else
    File.write(test_target, test_file)
  end

  puts "Succesfully generated files for #{year} day #{day}, called \"#{challenge_name}\". Have fun!."
rescue Errno::ENOENT => e
  puts "Error: #{e.message}"
rescue Errno::EACCES => e
  puts "Permission error: #{e.message}"
rescue StandardError => e
  puts "An unexpected error occurred: #{e.message}"
end