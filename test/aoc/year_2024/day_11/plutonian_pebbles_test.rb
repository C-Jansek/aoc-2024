require 'test_helper'

module Aoc
  module Year2024
    class Day11Test < Minitest::Test
      describe 'parsing' do
        it 'parses the input correctly into a storage block' do
          input = <<-INPUT
            0 1 10 99 999
          INPUT
          expected_stones = [0, 1, 10, 99, 999]
          assert_equal expected_stones, Day11.new.parse(input)
        end

        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_storage = [125, 17]
            assert_equal expected_storage, Day11.new.parse(Day11.example_input)
          end
        end
      end

      describe 'blinking' do
        it 'knows how to transform stones when you blink' do
          stones = [125, 17]
          assert_equal Hash[253000 => 1, 1 => 1, 7 => 1], Day11.new.blink(stones, 1)
          assert_equal Hash[253 => 1, 0 => 1, 2024 => 1, 14168 => 1], Day11.new.blink(stones, 2)
          assert_equal Hash[512072 => 1, 1 => 1, 20 => 1, 24 => 1, 28676032 => 1], Day11.new.blink(stones, 3)
          assert_equal Hash[512 => 1, 72 => 1, 2024 => 1, 2 => 2, 0 => 1, 4 => 1, 2867 => 1, 6032 => 1], Day11.new.blink(stones, 4)
          assert_equal Hash[1036288=>1, 7=>1, 2=>1, 20=>1, 24=>1, 4048=>2, 1=>1, 8096=>1, 28=>1, 67=>1, 60=>1, 32=>1], Day11.new.blink(stones, 5)
          assert_equal Hash[2097446912=>1, 14168=>1, 4048=>1, 2=>4, 0=>2, 4=>1, 40=>2, 48=>2, 2024=>1, 80=>1, 96=>1, 8=>1, 6=>2, 7=>1, 3=>1], Day11.new.blink(stones, 6)
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day11.example_input
          assert_equal 55312, Day11.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day11.personal_input
          assert_equal 186203, Day11.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day11.example_input
          assert_equal 65601038650482, Day11.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day11.personal_input
          assert_equal 221291560078593, Day11.new.part_two(personal_input)
        end
      end
    end
  end
end
