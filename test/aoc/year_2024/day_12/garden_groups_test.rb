require 'test_helper'

module Aoc
  module Year2024
    class Day12Test < Minitest::Test
      describe 'parsing' do
        it 'parses the input correctly into a grid' do
          input = <<-INPUT.strip
            AAAA
            BBCD
            BBCC
            EEEC
          INPUT
          expected_parsed = [
            ['A', 'A', 'A', 'A'],
            ['B', 'B', 'C', 'D'],
            ['B', 'B', 'C', 'C'],
            ['E', 'E', 'E', 'C']
          ]
          assert_equal expected_parsed, Day12.new.parse(input)
        end

        describe 'with the example input' do
          it 'parses the input correctly into a grid' do
            expected_parsed = [
              ['R', 'R', 'R', 'R', 'I', 'I', 'C', 'C', 'F', 'F'],
              ['R', 'R', 'R', 'R', 'I', 'I', 'C', 'C', 'C', 'F'],
              ['V', 'V', 'R', 'R', 'R', 'C', 'C', 'F', 'F', 'F'],
              ['V', 'V', 'R', 'C', 'C', 'C', 'J', 'F', 'F', 'F'],
              ['V', 'V', 'V', 'V', 'C', 'J', 'J', 'C', 'F', 'E'],
              ['V', 'V', 'I', 'V', 'C', 'C', 'J', 'J', 'E', 'E'],
              ['V', 'V', 'I', 'I', 'I', 'C', 'J', 'J', 'E', 'E'],
              ['M', 'I', 'I', 'I', 'I', 'I', 'J', 'J', 'E', 'E'],
              ['M', 'I', 'I', 'I', 'S', 'I', 'J', 'E', 'E', 'E'],
              ['M', 'M', 'M', 'I', 'S', 'S', 'J', 'E', 'E', 'E'],
            ]
            assert_equal expected_parsed, Day12.new.parse(Day12.example_input)
          end
        end
      end

      describe 'fencing costs' do
        it 'correcly calculates the fencing costs' do
          grid = [
            ['A', 'A', 'A', 'A'],
            ['B', 'B', 'C', 'D'],
            ['B', 'B', 'C', 'C'],
            ['E', 'E', 'E', 'C']
          ]
          assert_equal 40, Day12.new.find_fencing_cost(grid, 'A') # 4 * 10 = 40
          assert_equal 32, Day12.new.find_fencing_cost(grid, 'B') # 4 * 8 = 32
          assert_equal 40, Day12.new.find_fencing_cost(grid, 'C') # 4 * 10 = 40
          assert_equal 4, Day12.new.find_fencing_cost(grid, 'D') # 1 * 4 = 4,
          assert_equal 24, Day12.new.find_fencing_cost(grid, 'E') # 3 * 8 = 24
        end

        describe 'with split regions' do
          it 'correctly calculates the fencing costs' do
            grid = [
              ['O', 'O', 'O', 'O', 'O'],
              ['O', 'X', 'O', 'X', 'O'],
              ['O', 'O', 'O', 'O', 'O'],
              ['O', 'X', 'O', 'X', 'O'],
              ['O', 'O', 'O', 'O', 'O']
            ]
            assert_equal 756, Day12.new.find_fencing_cost(grid, 'O') # 21 * 36 = 756
            assert_equal 16, Day12.new.find_fencing_cost(grid, 'X') # 1 * 4 * 4 = 16
          end
        end

        describe 'with the example input' do
          it 'correctly calculates the fencing costs' do
            grid = Day12.new.parse(Day12.example_input)

            assert_equal 216, Day12.new.find_fencing_cost(grid, 'R') # 12 * 18 = 216.
            assert_equal 340, Day12.new.find_fencing_cost(grid, 'I') # 4 * 8 + 14 * 22 = 308 + 32 = 340.
            assert_equal 396, Day12.new.find_fencing_cost(grid, 'C') # 14 * 28 + 1 * 4 = 392 + 4 = 396.
            assert_equal 180, Day12.new.find_fencing_cost(grid, 'F') # 10 * 18 = 180.
            assert_equal 260, Day12.new.find_fencing_cost(grid, 'V') # 13 * 20 = 260.
            assert_equal 220, Day12.new.find_fencing_cost(grid, 'J') # 11 * 20 = 220.
            assert_equal 234, Day12.new.find_fencing_cost(grid, 'E') # 13 * 18 = 234.
            assert_equal 60, Day12.new.find_fencing_cost(grid, 'M') # 5 * 12 = 60.
            assert_equal 24, Day12.new.find_fencing_cost(grid, 'S') # 3 * 8 = 24.
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day12.example_input
          assert_equal 1930, Day12.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day12.personal_input
          assert_equal 1375476, Day12.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day12.example_input
          assert_equal 1206, Day12.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day12.personal_input
          assert_equal -1, Day12.new.part_two(personal_input)
        end
      end
    end
  end
end
