require 'test_helper'

module Aoc
  module Year2024
    class Day15Test < Minitest::Test
      describe 'parsing' do
        describe 'with the small example input' do
          it 'parses the input correctly into a grid with walls and boxes' do
            expected_walls = Set.new(
              [
                Day15::Point[0, 0], Day15::Point[1, 0], Day15::Point[2, 0], Day15::Point[3, 0], Day15::Point[4, 0], Day15::Point[5, 0], Day15::Point[6, 0], Day15::Point[7, 0],
                Day15::Point[0, 1], Day15::Point[7, 1],
                Day15::Point[0, 2], Day15::Point[1, 2], Day15::Point[7, 2],
                Day15::Point[0, 3], Day15::Point[7, 3],
                Day15::Point[0, 4], Day15::Point[2, 4], Day15::Point[7, 4],
                Day15::Point[0, 5], Day15::Point[7, 5],
                Day15::Point[0, 6], Day15::Point[7, 6],
                Day15::Point[0, 7], Day15::Point[1, 7], Day15::Point[2, 7], Day15::Point[3, 7], Day15::Point[4, 7], Day15::Point[5, 7], Day15::Point[6, 7], Day15::Point[7, 7]
              ]
            )

            expected_boxes = Set.new(
              [
                Day15::Point[3, 1],
                Day15::Point[5, 1],
                Day15::Point[4, 2],
                Day15::Point[4, 3],
                Day15::Point[4, 4],
                Day15::Point[4, 5]
              ]
            )
            expected_robot = Day15::Point[2, 2]

            warehouse = Day15.new.parse(Day15.example_input_small).dig(:warehouse)

            assert_equal expected_walls, warehouse.walls
            assert_equal expected_boxes, warehouse.boxes
            assert_equal expected_robot, warehouse.robot
          end

          it 'parses the input correctly into a grid with walls and boxes' do
            expected_moves = [:east, :north, :north, :west, :west, :west, :south, :south, :east, :south, :west, :west, :south, :east, :east]

            assert_equal expected_moves, Day15.new.parse(Day15.example_input_small).dig(:moves)
          end
        end
      end

      describe 'perform move' do
        it 'knows how to perform a move' do
          warehouse = Day15.new.parse(Day15.example_input_small).dig(:warehouse)

          warehouse.perform_move(:east)
          next_state = <<-NEXT_STATE.strip
              ########
              #..O.O.#
              ##@.O..#
              #...O..#
              #.#.O..#
              #...O..#
              #......#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:north)
          next_state = <<-NEXT_STATE.strip
              ########
              #.@O.O.#
              ##..O..#
              #...O..#
              #.#.O..#
              #...O..#
              #......#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:north)
          next_state = <<-NEXT_STATE.strip
              ########
              #.@O.O.#
              ##..O..#
              #...O..#
              #.#.O..#
              #...O..#
              #......#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:west)
          next_state = <<-NEXT_STATE.strip
              ########
              #..@OO.#
              ##..O..#
              #...O..#
              #.#.O..#
              #...O..#
              #......#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:west)
          next_state = <<-NEXT_STATE.strip
              ########
              #...@OO#
              ##..O..#
              #...O..#
              #.#.O..#
              #...O..#
              #......#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:west)
          next_state = <<-NEXT_STATE.strip
              ########
              #...@OO#
              ##..O..#
              #...O..#
              #.#.O..#
              #...O..#
              #......#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:south)
          next_state = <<-NEXT_STATE.strip
               ########
               #....OO#
               ##..@..#
               #...O..#
               #.#.O..#
               #...O..#
               #...O..#
               ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:south)
          next_state = <<-NEXT_STATE.strip
              ########
              #....OO#
              ##..@..#
              #...O..#
              #.#.O..#
              #...O..#
              #...O..#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:east)
          next_state = <<-NEXT_STATE.strip
              ########
              #....OO#
              ##.@...#
              #...O..#
              #.#.O..#
              #...O..#
              #...O..#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:south)
          next_state = <<-NEXT_STATE.strip
               ########
               #....OO#
               ##.....#
               #..@O..#
               #.#.O..#
               #...O..#
               #...O..#
               ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:west)
          next_state = <<-NEXT_STATE.strip
              ########
              #....OO#
              ##.....#
              #...@O.#
              #.#.O..#
              #...O..#
              #...O..#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:west)
          next_state = <<-NEXT_STATE.strip
              ########
              #....OO#
              ##.....#
              #....@O#
              #.#.O..#
              #...O..#
              #...O..#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:south)
          next_state = <<-NEXT_STATE.strip
               ########
               #....OO#
               ##.....#
               #.....O#
               #.#.O@.#
               #...O..#
               #...O..#
               ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:east)
          next_state = <<-NEXT_STATE.strip
              ########
              #....OO#
              ##.....#
              #.....O#
              #.#O@..#
              #...O..#
              #...O..#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes

          warehouse.perform_move(:east)
          next_state = <<-NEXT_STATE.strip
              ########
              #....OO#
              ##.....#
              #.....O#
              #.#O@..#
              #...O..#
              #...O..#
              ########
          NEXT_STATE
          next_warehouse = Day15::Warehouse.new(next_state)
          assert_equal next_warehouse.robot, warehouse.robot
          assert_equal next_warehouse.walls, warehouse.walls
          assert_equal next_warehouse.boxes, warehouse.boxes
        end

        describe 'with a double wide warehouse' do
          it 'knows how to perform a move' do
            input = <<-INPUT.strip
              #######
              #...#.#
              #.....#
              #..OO@#
              #..O..#
              #.....#
              #######
              
              <vv<<^^<<^^
            INPUT
            ##############
            ##......##..##
            ##..........##
            ##....[][]@.##
            ##....[]....##
            ##..........##
            ##############
            warehouse = Day15.new.parse(input, part_two: true).dig(:warehouse)
            assert_equal Set.new([Day15::Point[6, 3],Day15::Point[8, 3],Day15::Point[6, 4]]), warehouse.boxes
            assert_equal Day15::Point[10, 3], warehouse.robot

            warehouse.perform_move(:east)
            ##############
            ##......##..##
            ##..........##
            ##...[][]@..##
            ##....[]....##
            ##..........##
            ##############
            assert_equal Set.new([Day15::Point[5, 3],Day15::Point[7, 3],Day15::Point[6, 4]]), warehouse.boxes
            assert_equal Day15::Point[9, 3], warehouse.robot

            warehouse.perform_move(:south)

            ##############
            ##......##..##
            ##..........##
            ##...[][]...##
            ##....[].@..##
            ##..........##
            ##############

            warehouse.perform_move(:south)

            ##############
            ##......##..##
            ##..........##
            ##...[][]...##
            ##....[]....##
            ##.......@..##
            ##############

            warehouse.perform_move(:east)

            ##############
            ##......##..##
            ##..........##
            ##...[][]...##
            ##....[]....##
            ##......@...##
            ##############

            warehouse.perform_move(:east)

            ##############
            ##......##..##
            ##..........##
            ##...[][]...##
            ##....[]....##
            ##.....@....##
            ##############

            warehouse.perform_move(:north)

            ##############
            ##......##..##
            ##...[][]...##
            ##....[]....##
            ##.....@....##
            ##..........##
            ##############

            warehouse.perform_move(:north)

            ##############
            ##......##..##
            ##...[][]...##
            ##....[]....##
            ##.....@....##
            ##..........##
            ##############

            warehouse.perform_move(:east)

            ##############
            ##......##..##
            ##...[][]...##
            ##....[]....##
            ##....@.....##
            ##..........##
            ##############

            warehouse.perform_move(:east)

            ##############
            ##......##..##
            ##...[][]...##
            ##....[]....##
            ##...@......##
            ##..........##
            ##############

            warehouse.perform_move(:north)

            ##############
            ##......##..##
            ##...[][]...##
            ##...@[]....##
            ##..........##
            ##..........##
            ##############

            warehouse.perform_move(:north)

            ##############
            ##...[].##..##
            ##...@.[]...##
            ##....[]....##
            ##..........##
            ##..........##
            ##############
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the small example' do
          example_input = Day15.example_input_small
          assert_equal 2028, Day15.new.part_one(example_input)
        end

        it 'provides the correct answer for the large example' do
          example_input = Day15.example_input_large
          assert_equal 10092, Day15.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day15.personal_input
          assert_equal 1448589, Day15.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the large example' do
          example_input = Day15.example_input_large
          assert_equal 9021, Day15.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day15.personal_input
          assert_equal 1472235, Day15.new.part_two(personal_input)
        end
      end
    end
  end
end
