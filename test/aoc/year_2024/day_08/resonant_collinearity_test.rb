require 'test_helper'

module Aoc
  module Year2024
    class Day08Test < Minitest::Test
      describe 'parsing' do
        it 'parses the input correctly into answers and numbers' do
          expected_antennas = {}
          expected_antennas['0'] = [[8, 1], [5, 2], [7, 3], [4, 4]]
          expected_antennas['A'] = [[6, 5], [8, 8], [9, 9]]

          assert_equal expected_antennas, Day08.new.parse(Day08.example_input).dig(:antennas)
        end

        it 'finds the size of the map' do
          assert_equal 12, Day08.new.parse(Day08.example_input).dig(:width)
          assert_equal 12, Day08.new.parse(Day08.example_input).dig(:height)
        end
      end

      describe 'antinodes' do
        it 'knows where the antinodes of two points are' do
          points = [
            [5, 3],
            [6, 5]
          ]
          expected_antinodes = [
            [4, 1],
            [7, 7]
          ]
          assert_equal expected_antinodes, Day08.new.find_antinodes_to_the_side(*points)
        end

        it 'knows where the antinodes of more than two points are' do
          points = [
            [8, 1],
            [5, 2],
            [7, 3],
            [4, 4]
          ]
          expected_antinodes = [
            [12, -2], # outside
            [9, -1], # outside
            [6, 0],
            [11, 0],
            [3, 1],
            [10, 2],
            [2, 3],
            [9, 4],
            [1, 5],
            [6, 5],
            [3, 6],
            [0, 7],
          ]
          assert_equal expected_antinodes.sort, Day08.new.find_all_antinodes_to_the_side(points).sort
        end

        describe 'when there are antinodes at every grid point in line with two antennas' do
          it 'knows where the antinodes of two points are within the grid' do
            # "T....#...."
            # "...T......"
            # "......#..."
            # ".........#"
            # ".........."
            width = 10
            height = 5
            points = [
              [0, 0],
              [3, 1]
            ]
            expected_antinodes = [
              [0, 0],
              [3, 1],
              [6, 2],
              [9, 3],
            ]
            assert_equal expected_antinodes, Day08.new.find_antinodes(*points, width, height)
          end

          it 'knows where the antinodes of more than two points are within the grid' do
            # "T....#...."
            # "...T......"
            # ".T....#..."
            # ".........#"
            # "..#......."
            # ".........."
            # "...#......"
            # ".........."
            # "....#....."
            # ".........."
            width = 10
            height = 10
            points = [
              [0, 0],
              [3, 1],
              [1, 2]
            ]
            expected_antinodes = [
              [0, 0], # original
              [5, 0],
              [3, 1], # original
              [1, 2], # original
              [6, 2],
              [9, 3],
              [2, 4],
              [3, 6],
              [4, 8]
            ]
            assert_equal expected_antinodes.sort, Day08.new.find_all_antinodes(points, width, height).sort
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day08.example_input
          assert_equal 14, Day08.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day08.personal_input
          assert_equal 254, Day08.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day08.example_input
          assert_equal 34, Day08.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day08.personal_input
          assert_equal 951, Day08.new.part_two(personal_input)
        end
      end
    end
  end
end
