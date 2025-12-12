require 'test_helper'

module Aoc
  module Year2025
    class Day09Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = [
              Day09::RedTile.new(7, 1),
              Day09::RedTile.new(11, 1),
              Day09::RedTile.new(11, 7),
              Day09::RedTile.new(9, 7),
              Day09::RedTile.new(9, 5),
              Day09::RedTile.new(2, 5),
              Day09::RedTile.new(2, 3),
              Day09::RedTile.new(7, 3)
            ]
            assert_equal expected_parsed, Day09.new.parse(Day09.example_input)
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day09.example_input
          assert_equal 50, Day09.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day09.personal_input
          assert_equal 4777967538, Day09.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day09.example_input
          assert_equal 24, Day09.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day09.personal_input
          assert_equal 1439894345, Day09.new.part_two(personal_input)
        end
      end
    end
  end
end
