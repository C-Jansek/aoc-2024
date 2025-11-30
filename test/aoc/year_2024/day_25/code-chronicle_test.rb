require 'test_helper'

module Aoc
  module Year2024
    class Day25Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_locks = [
              [0, 5, 3, 4, 3],
              [1, 2, 0, 5, 3]
            ]
            expected_keys = [
              [5, 0, 2, 1, 3],
              [4, 3, 4, 0, 2],
              [3, 0, 2, 0, 1]
            ]
            assert_equal expected_locks, Day25.new.parse(Day25.example_input).first
            assert_equal expected_keys, Day25.new.parse(Day25.example_input).last
          end
        end
      end

      describe 'lock?' do
        it 'knows if a block is a key or a lock' do
          assert Day25.new.lock?(["#####", ".####", ".####", ".####", ".#.#.", ".#...", "....."].map { it.split('') })
          refute Day25.new.lock?([".....", "#....", "#....", "#...#", "#.#.#", "#.###", "#####"].map { it.split('') })
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day25.example_input
          assert_equal 3, Day25.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day25.personal_input
          assert_equal 2618, Day25.new.part_one(personal_input)
        end
      end
    end
  end
end
