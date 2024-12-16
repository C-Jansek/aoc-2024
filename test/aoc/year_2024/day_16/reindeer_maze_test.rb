require 'test_helper'

module Aoc
  module Year2024
    class Day16Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly a grid with a reindeer at a starting position' do
            expected_points = [
              %w[# # # # # # # # # # # # # # #],
              %w[# . . . . . . . # . . . . E #],
              %w[# . # . # # # . # . # # # . #],
              %w[# . . . . . # . # . . . # . #],
              %w[# . # # # . # # # # # . # . #],
              %w[# . # . # . . . . . . . # . #],
              %w[# . # . # # # # # . # # # . #],
              %w[# . . . . . . . . . . . # . #],
              %w[# # # . # . # # # # # . # . #],
              %w[# . . . # . . . . . # . # . #],
              %w[# . # . # . # # # . # . # . #],
              %w[# . . . . . # . . . # . # . #],
              %w[# . # # # . # . # . # . # . #],
              %w[# S . . # . . . . . # . . . #],
              %w[# # # # # # # # # # # # # # #]
            ]
            parsed = Day16.new.parse(Day16.example_input)
            assert_equal expected_points, parsed.dig(:grid).points
            assert_equal Helpers::Grid::Point[1, 13], parsed.dig(:start)
            assert_equal Helpers::Grid::Directions::EAST, parsed.dig(:start_direction)
            assert_equal Helpers::Grid::Point[13, 1], parsed.dig(:finish)
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the small example' do
          example_input = Day16.small_example_input
          assert_equal 7036, Day16.new.part_one(example_input)
        end

        it 'provides the correct answer for the large example' do
          example_input = Day16.large_example_input
          assert_equal 11048, Day16.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day16.personal_input
          assert_equal 90460, Day16.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day16.example_input
          assert_equal -1, Day16.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day16.personal_input
          assert_equal -1, Day16.new.part_two(personal_input)
        end
      end
    end
  end
end
