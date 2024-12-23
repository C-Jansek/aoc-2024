require 'test_helper'

module Aoc
  module Year2024
    class Day20Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_track = [
              Helpers::Grid::Point[1, 3],
              Helpers::Grid::Point[1, 2],
              Helpers::Grid::Point[1, 1],
              Helpers::Grid::Point[2, 1],
              Helpers::Grid::Point[3, 1],
              Helpers::Grid::Point[3, 2],
              Helpers::Grid::Point[3, 3],
              Helpers::Grid::Point[4, 3],
              Helpers::Grid::Point[5, 3],
              Helpers::Grid::Point[5, 2],
              Helpers::Grid::Point[5, 1],
              Helpers::Grid::Point[6, 1],
              Helpers::Grid::Point[7, 1],
              Helpers::Grid::Point[7, 2],
              Helpers::Grid::Point[7, 3],
              Helpers::Grid::Point[7, 4],
              Helpers::Grid::Point[7, 5],
              Helpers::Grid::Point[7, 6],
              Helpers::Grid::Point[7, 7],
              Helpers::Grid::Point[8, 7],
              Helpers::Grid::Point[9, 7],
              Helpers::Grid::Point[9, 6],
              Helpers::Grid::Point[9, 5],
              Helpers::Grid::Point[9, 4],
              Helpers::Grid::Point[9, 3],
              Helpers::Grid::Point[9, 2],
              Helpers::Grid::Point[9, 1],
              Helpers::Grid::Point[10, 1],
              Helpers::Grid::Point[11, 1],
              Helpers::Grid::Point[12, 1],
              Helpers::Grid::Point[13, 1],
              Helpers::Grid::Point[13, 2],
              Helpers::Grid::Point[13, 3],
              Helpers::Grid::Point[12, 3],
              Helpers::Grid::Point[11, 3],
              Helpers::Grid::Point[11, 4],
              Helpers::Grid::Point[11, 5],
              Helpers::Grid::Point[12, 5],
              Helpers::Grid::Point[13, 5],
              Helpers::Grid::Point[13, 6],
              Helpers::Grid::Point[13, 7],
              Helpers::Grid::Point[12, 7],
              Helpers::Grid::Point[11, 7],
              Helpers::Grid::Point[11, 8],
              Helpers::Grid::Point[11, 9],
              Helpers::Grid::Point[12, 9],
              Helpers::Grid::Point[13, 9],
              Helpers::Grid::Point[13, 10],
              Helpers::Grid::Point[13, 11],
              Helpers::Grid::Point[12, 11],
              Helpers::Grid::Point[11, 11],
              Helpers::Grid::Point[11, 12],
              Helpers::Grid::Point[11, 13],
              Helpers::Grid::Point[10, 13],
              Helpers::Grid::Point[9, 13],
              Helpers::Grid::Point[9, 12],
              Helpers::Grid::Point[9, 11],
              Helpers::Grid::Point[9, 10],
              Helpers::Grid::Point[9, 9],
              Helpers::Grid::Point[8, 9],
              Helpers::Grid::Point[7, 9],
              Helpers::Grid::Point[7, 10],
              Helpers::Grid::Point[7, 11],
              Helpers::Grid::Point[7, 12],
              Helpers::Grid::Point[7, 13],
              Helpers::Grid::Point[6, 13],
              Helpers::Grid::Point[5, 13],
              Helpers::Grid::Point[5, 12],
              Helpers::Grid::Point[5, 11],
              Helpers::Grid::Point[4, 11],
              Helpers::Grid::Point[3, 11],
              Helpers::Grid::Point[3, 12],
              Helpers::Grid::Point[3, 13],
              Helpers::Grid::Point[2, 13],
              Helpers::Grid::Point[1, 13],
              Helpers::Grid::Point[1, 12],
              Helpers::Grid::Point[1, 11],
              Helpers::Grid::Point[1, 10],
              Helpers::Grid::Point[1, 9],
              Helpers::Grid::Point[2, 9],
              Helpers::Grid::Point[3, 9],
              Helpers::Grid::Point[3, 8],
              Helpers::Grid::Point[3, 7],
              Helpers::Grid::Point[4, 7],
              Helpers::Grid::Point[5, 7]
            ]
            expected_start = Helpers::Grid::Point[1, 3]
            expected_finish = Helpers::Grid::Point[5, 7]
            assert_equal expected_start, Day20.new.parse(Day20.example_input)[:start]
            assert_equal expected_finish, Day20.new.parse(Day20.example_input)[:finish]
            assert_equal expected_track, Day20.new.parse(Day20.example_input)[:track]
          end
        end
        describe 'with the real input' do
          it 'parses the input correctly into a storage block' do
            expected_track = [
              Helpers::Grid::Point[1, 3],
              Helpers::Grid::Point[1, 2],
              Helpers::Grid::Point[1, 1],
              Helpers::Grid::Point[2, 1],
              Helpers::Grid::Point[3, 1],
              Helpers::Grid::Point[3, 2],
              Helpers::Grid::Point[3, 3],
              Helpers::Grid::Point[4, 3],
              Helpers::Grid::Point[5, 3],
              Helpers::Grid::Point[5, 2],
              Helpers::Grid::Point[5, 1],
              Helpers::Grid::Point[6, 1],
              Helpers::Grid::Point[7, 1],
              Helpers::Grid::Point[7, 2],
              Helpers::Grid::Point[7, 3],
              Helpers::Grid::Point[7, 4],
              Helpers::Grid::Point[7, 5],
              Helpers::Grid::Point[7, 6],
              Helpers::Grid::Point[7, 7],
              Helpers::Grid::Point[8, 7],
              Helpers::Grid::Point[9, 7],
              Helpers::Grid::Point[9, 6],
              Helpers::Grid::Point[9, 5],
              Helpers::Grid::Point[9, 4],
              Helpers::Grid::Point[9, 3],
              Helpers::Grid::Point[9, 2],
              Helpers::Grid::Point[9, 1],
              Helpers::Grid::Point[10, 1],
              Helpers::Grid::Point[11, 1],
              Helpers::Grid::Point[12, 1],
              Helpers::Grid::Point[13, 1],
              Helpers::Grid::Point[13, 2],
              Helpers::Grid::Point[13, 3],
              Helpers::Grid::Point[12, 3],
              Helpers::Grid::Point[11, 3],
              Helpers::Grid::Point[11, 4],
              Helpers::Grid::Point[11, 5],
              Helpers::Grid::Point[12, 5],
              Helpers::Grid::Point[13, 5],
              Helpers::Grid::Point[13, 6],
              Helpers::Grid::Point[13, 7],
              Helpers::Grid::Point[12, 7],
              Helpers::Grid::Point[11, 7],
              Helpers::Grid::Point[11, 8],
              Helpers::Grid::Point[11, 9],
              Helpers::Grid::Point[12, 9],
              Helpers::Grid::Point[13, 9],
              Helpers::Grid::Point[13, 10],
              Helpers::Grid::Point[13, 11],
              Helpers::Grid::Point[12, 11],
              Helpers::Grid::Point[11, 11],
              Helpers::Grid::Point[11, 12],
              Helpers::Grid::Point[11, 13],
              Helpers::Grid::Point[10, 13],
              Helpers::Grid::Point[9, 13],
              Helpers::Grid::Point[9, 12],
              Helpers::Grid::Point[9, 11],
              Helpers::Grid::Point[9, 10],
              Helpers::Grid::Point[9, 9],
              Helpers::Grid::Point[8, 9],
              Helpers::Grid::Point[7, 9],
              Helpers::Grid::Point[7, 10],
              Helpers::Grid::Point[7, 11],
              Helpers::Grid::Point[7, 12],
              Helpers::Grid::Point[7, 13],
              Helpers::Grid::Point[6, 13],
              Helpers::Grid::Point[5, 13],
              Helpers::Grid::Point[5, 12],
              Helpers::Grid::Point[5, 11],
              Helpers::Grid::Point[4, 11],
              Helpers::Grid::Point[3, 11],
              Helpers::Grid::Point[3, 12],
              Helpers::Grid::Point[3, 13],
              Helpers::Grid::Point[2, 13],
              Helpers::Grid::Point[1, 13],
              Helpers::Grid::Point[1, 12],
              Helpers::Grid::Point[1, 11],
              Helpers::Grid::Point[1, 10],
              Helpers::Grid::Point[1, 9],
              Helpers::Grid::Point[2, 9],
              Helpers::Grid::Point[3, 9],
              Helpers::Grid::Point[3, 8],
              Helpers::Grid::Point[3, 7],
              Helpers::Grid::Point[4, 7],
              Helpers::Grid::Point[5, 7]
            ]
            expected_start = Helpers::Grid::Point[25, 47]
            expected_finish = Helpers::Grid::Point[11, 33]
            parsed = Day20.new.parse(Day20.personal_input)
            assert_equal expected_start, parsed[:start]
            assert_equal expected_finish, parsed[:finish]
            assert_equal expected_track, parsed[:track]
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day20.example_input
          assert_equal 382, Day20.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day20.personal_input
          assert_equal 1263, Day20.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example using part one rules' do
          example_input = Day20.example_input
          assert_equal 44, Day20.new.part_two(example_input, minimum_shortcut_length: 1, max_glitch_duration: 2)
        end

        it 'provides the correct answer for the personal input using part one rules' do
          personal_input = Day20.personal_input
          assert_equal 1263, Day20.new.part_two(personal_input, minimum_shortcut_length: 100, max_glitch_duration: 2)
        end

        it 'provides the correct answer for the example' do
          example_input = Day20.example_input
          assert_equal 285, Day20.new.part_two(example_input, minimum_shortcut_length: 50, max_glitch_duration: 20)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day20.personal_input
          assert_equal 957831, Day20.new.part_two(personal_input, minimum_shortcut_length: 100, max_glitch_duration: 20)
        end
      end
    end
  end
end
