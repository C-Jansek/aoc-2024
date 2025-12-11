require 'test_helper'

module Aoc
  module Year2025
    class Day11Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = [
              Day11::Node.new('aaa', ['you','hhh']),
              Day11::Node.new('you', ['bbb','ccc']),
              Day11::Node.new('bbb', ['ddd','eee']),
              Day11::Node.new('ccc', ['ddd','eee','fff']),
              Day11::Node.new('ddd', ['ggg']),
              Day11::Node.new('eee', ['out']),
              Day11::Node.new('fff', ['out']),
              Day11::Node.new('ggg', ['out']),
              Day11::Node.new('hhh', ['ccc','fff','iii']),
              Day11::Node.new('iii', ['out']),
            ]
            assert_equal expected_parsed, Day11.new.parse(Day11.example_input)
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day11.example_input
          assert_equal 5, Day11.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day11.personal_input
          assert_equal 466, Day11.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day11.example_input_part_two
          assert_equal 2, Day11.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day11.personal_input
          assert_equal 549705036748518, Day11.new.part_two(personal_input)
        end
      end
    end
  end
end
