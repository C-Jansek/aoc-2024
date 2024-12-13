require 'test_helper'

module Aoc
  module Year2024
    class Day13Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into claw machines' do
            expected_parsed = [
              Day13::ClawMachine[ax: 94, ay: 34, bx: 22, by: 67, prize_x: 8400, prize_y: 5400],
              Day13::ClawMachine[ax: 26, ay: 66, bx: 67, by: 21, prize_x: 12748, prize_y: 12176],
              Day13::ClawMachine[ax: 17, ay: 86, bx: 84, by: 37, prize_x: 7870, prize_y: 6450],
              Day13::ClawMachine[ax: 69, ay: 23, bx: 27, by: 71, prize_x: 18641, prize_y: 10279]
            ]
            assert_equal expected_parsed, Day13.new.parse(Day13.example_input)
          end
        end
      end

      describe 'given a claw machine' do
        it 'finds the solution to the claw machine' do
          claw_machine = Day13::ClawMachine[ax: 94, ay: 34, bx: 22, by: 67, prize_x: 8400, prize_y: 5400]
          assert_equal [80, 40], Day13.new.find_solution_to_claw_machine(claw_machine)

          claw_machine = Day13::ClawMachine[ax: 26, ay: 66, bx: 67, by: 21, prize_x: 12748, prize_y: 12176]
          refute Day13.new.find_solution_to_claw_machine(claw_machine)

          claw_machine = Day13::ClawMachine[ax: 17, ay: 86, bx: 84, by: 37, prize_x: 7870, prize_y: 6450]
          assert_equal [38, 86], Day13.new.find_solution_to_claw_machine(claw_machine)

          claw_machine = Day13::ClawMachine[ax: 69, ay: 23, bx: 27, by: 71, prize_x: 18641, prize_y: 10279]
          refute Day13.new.find_solution_to_claw_machine(claw_machine)

        end

        it 'finds the solution with big prize coordinates' do
          claw_machine = Day13::ClawMachine[ax: 94, ay: 34, bx: 22, by: 67, prize_x: 8400 + 10_000_000_000_000, prize_y: 5400 + 10_000_000_000_000]
          refute Day13.new.find_solution_to_claw_machine(claw_machine)

          claw_machine = Day13::ClawMachine[ax: 26, ay: 66, bx: 67, by: 21, prize_x: 12748 + 10_000_000_000_000, prize_y: 12176 + 10_000_000_000_000]
          assert_equal [118679050709, 103199174542], Day13.new.find_solution_to_claw_machine(claw_machine)

          claw_machine = Day13::ClawMachine[ax: 17, ay: 86, bx: 84, by: 37, prize_x: 7870 + 10_000_000_000_000, prize_y: 6450 + 10_000_000_000_000]
          refute Day13.new.find_solution_to_claw_machine(claw_machine)

          claw_machine = Day13::ClawMachine[ax: 69, ay: 23, bx: 27, by: 71, prize_x: 18641 + 10_000_000_000_000, prize_y: 10279 + 10_000_000_000_000]
          assert_equal [102851800151, 107526881786], Day13.new.find_solution_to_claw_machine(claw_machine)
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day13.example_input
          assert_equal 480, Day13.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day13.personal_input
          assert_equal 31589, Day13.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day13.example_input
          assert_equal 875318608908, Day13.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day13.personal_input
          assert_equal 98080815200063, Day13.new.part_two(personal_input)
        end
      end
    end
  end
end
