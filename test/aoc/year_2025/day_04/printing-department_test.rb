require 'test_helper'

module Aoc
  module Year2025
    class Day04Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            test_input = <<~test
              .@
              @.
              ..
            test
            expected_parsed = [
              [Day04::Cell.new(0, 0, '.'),
               Day04::Cell.new(0, 1, '@')],
              [Day04::Cell.new(1, 0, '@'),
               Day04::Cell.new(1, 1, '.')],
              [Day04::Cell.new(2, 0, '.'),
               Day04::Cell.new(2, 1, '.')],
            ]
            assert_equal expected_parsed, Day04.new.parse(test_input)
          end
        end
      end

      describe 'neighbours' do
        it 'knows which neighbours there are and removes the ones that are out of bounds' do
          grid = [
            [Day04::Cell.new(0, 0, '.'),
             Day04::Cell.new(0, 1, '@')],
            [Day04::Cell.new(1, 0, '@'),
             Day04::Cell.new(1, 1, '.')],
            [Day04::Cell.new(2, 0, '.'),
             Day04::Cell.new(2, 1, '.')],
          ]
          assert_equal [Day04::Cell.new(0, 1, '@'),
                        Day04::Cell.new(1, 0, '@'),
                        Day04::Cell.new(1, 1, '.')],
                       Day04.new.neighbours(grid, 0, 0)
          assert_equal [Day04::Cell.new(0, 0, '.'),
                        Day04::Cell.new(0, 1, '@'),
                        Day04::Cell.new(1, 0, '@'),
                        Day04::Cell.new(2, 0, '.'),
                        Day04::Cell.new(2, 1, '.')],
                       Day04.new.neighbours(grid, 1, 1)

        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day04.example_input
          assert_equal 13, Day04.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day04.personal_input
          assert_equal 1363, Day04.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day04.example_input
          assert_equal 43, Day04.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day04.personal_input
          assert_equal 8184, Day04.new.part_two(personal_input)
        end
      end
    end
  end
end
