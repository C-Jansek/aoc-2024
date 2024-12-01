def parse
  input = File.open("#{__dir__}/./input.txt").read
  # input = <<-MSG.strip
  #   3   4
  #   4   3
  #   2   5
  #   1   3
  #   3   9
  #   3   3
  # MSG

  left_location_ids = []
  right_location_ids = []

  input.lines.each do |row|
    next if row == ''

    left_location_id, right_location_id = row.match(/(\d+)\s+(\d+)/)[1, 2].map(&:to_i)
    left_location_ids << left_location_id
    right_location_ids << right_location_id
  end

  [left_location_ids, right_location_ids]
end

def part_one
  left_location_ids, right_location_ids = parse

  sorted_left_location_ids = left_location_ids.sort
  sorted_right_location_ids = right_location_ids.sort

  distances = sorted_left_location_ids.zip(sorted_right_location_ids).map do |left, right|
    (left - right).abs
  end

  distances.sum
end

def part_two
  left_location_ids, right_location_ids = parse

  similarity_scores_of_ids = {}

  left_location_ids.each do |location_id|
    next if similarity_scores_of_ids.key?(location_id)

    similarity_scores_of_ids[location_id] = location_id * right_location_ids.count(location_id)
  end

  left_location_ids.reduce(0) do |sum, location_id|
    sum + similarity_scores_of_ids[location_id]
  end
end

puts "Part one: #{part_one}"
puts "Part one: #{part_two}"