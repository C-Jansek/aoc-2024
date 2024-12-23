module Aoc
  module Year2024
    class Day20
      def self.example_input
        <<-INPUT.strip
          ###############
          #...#...#.....#
          #.#.#.#.#.###.#
          #S#...#.#.#...#
          #######.#.#.###
          #######.#.#...#
          #######.#.###.#
          ###..E#...#...#
          ###.#######.###
          #...###...#...#
          #.#####.#.###.#
          #.#...#.#.#...#
          #.#.#.#.#.#.###
          #...#...#...###
          ###############
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        start = nil
        finish = nil

        points = input.strip.lines.each_with_index.map do |line, y|
          line.strip.split('').each_with_index.map do |cell, x|
            if cell == 'S'
              start = Helpers::Grid::Point[x, y]
            elsif cell == 'E'
              finish = Helpers::Grid::Point[x, y]
            end

            cell == '#' ? '#' : '.'
          end
        end

        track = []
        next_point = start
        count = 0
        until next_point == finish
          track << next_point

          Helpers::Grid::Directions::ALL_DIRECT.each do |direction|
            delta = Helpers::Grid::DIRECTION_TO_DELTA[direction]
            neighbour_point = Helpers::Grid::Point[next_point.x + delta.x, next_point.y + delta.y]
            neighbour_value = points[neighbour_point.y][neighbour_point.x]

            if neighbour_point != track.fetch(-2, nil) && neighbour_value != '#'
              next_point = neighbour_point
              break
            end
          end
          count += 1
        end

        track << finish

        {
          points: points,
          start: start,
          finish: finish,
          track: track,
          width: points[0].length,
          height: points.length,
        }
      end

      def part_one(input)
        parsed = parse(input)

        track = parsed[:track]
        start = parsed[:start]
        finish = parsed[:finish]
        points = parsed[:points]
        width = parsed[:width]
        height = parsed[:height]

        track.each_with_index.map do |track_point, shortcut_start_index|
          neighbours = Helpers::Grid::Directions::ALL_DIRECT.map do |direction|
            delta = Helpers::Grid::DIRECTION_TO_DELTA[direction]
            neighbour_point = Helpers::Grid::Point[track_point.x + 2 * delta.x, track_point.y + 2 * delta.y]
            next unless neighbour_point.x.between?(0, width - 1) && neighbour_point.y.between?(0, height - 1)

            neighbour_value = points[neighbour_point.y][neighbour_point.x]

            next if neighbour_value == '#'

            neighbour_point
          end.compact

          neighbours.map do |point|
            shortcut_end_index = track.index(point)
            next if shortcut_end_index.nil?

            shortcut_length = shortcut_end_index - shortcut_start_index - 2
            next if shortcut_length < 100

            shortcut_length
          end.flatten.compact
        end.flatten.compact.count
      end

      def manhattan_distance(a, b)
        (a.x - b.x).abs + (a.y - b.y).abs
      end

      def part_two(input, max_glitch_duration: false, minimum_shortcut_length: 100)
        parsed = parse(input)

        track = parsed[:track]

        shortcut_lengths = track.each_with_index.map do |shortcut_start, shortcut_start_index|
          minimum_shortcut_end_index = shortcut_start_index + minimum_shortcut_length
          next if minimum_shortcut_end_index >= track.length

          track[minimum_shortcut_end_index..-1].each_with_index.map do |shortcut_end, shortcut_end_partial_index|
            required_glitch_duration_for_shortcut = manhattan_distance(shortcut_start, shortcut_end)
            next nil if required_glitch_duration_for_shortcut > max_glitch_duration

            shortcut_end_index = minimum_shortcut_end_index + shortcut_end_partial_index
            track_skipped_length = shortcut_end_index - shortcut_start_index
            shortcut_length = track_skipped_length - required_glitch_duration_for_shortcut

            next nil if shortcut_length < minimum_shortcut_length

            shortcut_length
          end
        end
        shortcut_lengths.flatten.compact.count
      end
    end
  end
end
