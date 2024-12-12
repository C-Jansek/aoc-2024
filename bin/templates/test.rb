require 'test_helper'

module Aoc
  module YearYYYY
    class DayDDTest < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = nil
            assert_equal expected_parsed, DayDD.new.parse(DayDD.example_input)
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = DayDD.example_input
          assert_equal -1, DayDD.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = DayDD.personal_input
          assert_equal -1, DayDD.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = DayDD.example_input
          assert_equal -1, DayDD.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = DayDD.personal_input
          assert_equal -1, DayDD.new.part_two(personal_input)
        end
      end
    end
  end
end
