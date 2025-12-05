require 'test_helper'

module Aoc
  module Year2025
    class Day05Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = Day05::Input.new(
              [Day05::Range.new(3, 5),
               Day05::Range.new(10, 14),
               Day05::Range.new(16, 20),
               Day05::Range.new(12, 18)],
              [1, 5, 8, 11, 17, 32]
            )
            assert_equal expected_parsed, Day05.new.parse(Day05.example_input)
          end
        end
      end

      describe 'spoiled' do
        it 'knows if an ingredient id is part of a fresh range' do
          fresh_ranges = [Day05::Range.new(3, 5),
                          Day05::Range.new(10, 14),
                          Day05::Range.new(16, 20),
                          Day05::Range.new(12, 18)]

          refute Day05.new.fresh_ingredient?(fresh_ranges, 1)
          assert Day05.new.fresh_ingredient?(fresh_ranges, 5)
          refute Day05.new.fresh_ingredient?(fresh_ranges, 8)
          assert Day05.new.fresh_ingredient?(fresh_ranges, 11)
          assert Day05.new.fresh_ingredient?(fresh_ranges, 17)
          refute Day05.new.fresh_ingredient?(fresh_ranges, 32)
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day05.example_input
          assert_equal 3, Day05.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day05.personal_input
          assert_equal 770, Day05.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day05.example_input
          assert_equal 14, Day05.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day05.personal_input
          assert_equal 357674099117260, Day05.new.part_two(personal_input)
        end
      end
    end
  end
end
