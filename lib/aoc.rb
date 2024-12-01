files = File.join(File.dirname(__FILE__), "aoc", "**", "*.rb")

Dir[files].each do |file|
  require file
end
