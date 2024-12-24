require 'test_helper'

module Aoc
  module Year2024
    class Day24Test < Minitest::Test
      describe 'parsing' do
        describe 'with the small example input' do
          it 'parses the input correctly into a storage block' do
            expected_initial_wire_values = {
              x00: 1,
              x01: 1,
              x02: 1,
              y00: 0,
              y01: 1,
              y02: 0
            }
            expected_gates = {
              z00: Day24::Gate[Day24::GateTypes::AND, :x00, :y00],
              z01: Day24::Gate[Day24::GateTypes::XOR, :x01, :y01],
              z02: Day24::Gate[Day24::GateTypes::OR, :x02, :y02]
            }

            parsed = Day24.new.parse(Day24.small_example_input)

            assert_equal expected_initial_wire_values, parsed[:initial_wire_values]
            assert_equal expected_gates, parsed[:gates]
          end
        end
      end

      describe 'performing gates' do
        it 'knows what the final values of the wires are' do
          initial_wire_values = {
            x00: 1,
            x01: 1,
            x02: 1,
            y00: 0,
            y01: 1,
            y02: 0
          }
          gates = {
            z00: Day24::Gate[Day24::GateTypes::AND, :x00, :y00],
            z01: Day24::Gate[Day24::GateTypes::XOR, :x01, :y01],
            z02: Day24::Gate[Day24::GateTypes::OR, :x02, :y02]
          }

          processed_wire_values = Day24.process_gates(initial_wire_values, gates)

          assert_equal 0, processed_wire_values[:z00]
          assert_equal 0, processed_wire_values[:z01]
          assert_equal 1, processed_wire_values[:z02]
        end

        describe 'with the big example input' do
          it 'knows what the final values of the wires are' do
            parsed = Day24.new.parse(Day24.big_example_input)
            processed_wire_values = Day24.process_gates(parsed[:initial_wire_values], parsed[:gates])

            assert_equal 0, processed_wire_values[:z00]
            assert_equal 0, processed_wire_values[:z01]
            assert_equal 0, processed_wire_values[:z02]
            assert_equal 1, processed_wire_values[:z03]
            assert_equal 0, processed_wire_values[:z04]
            assert_equal 1, processed_wire_values[:z05]
            assert_equal 1, processed_wire_values[:z06]
            assert_equal 1, processed_wire_values[:z07]
            assert_equal 1, processed_wire_values[:z08]
            assert_equal 1, processed_wire_values[:z09]
            assert_equal 1, processed_wire_values[:z10]
            assert_equal 0, processed_wire_values[:z11]
            assert_equal 0, processed_wire_values[:z12]
          end
        end
      end

      describe '#binary_output' do
        it 'can find the binary output from the processed wires' do
          processed_wire_values = {
            z00: 0,
            z01: 0,
            z02: 0,
            z03: 1,
            z04: 0,
            z05: 1,
            z06: 1,
            z07: 1,
            z08: 1,
            z09: 1,
            z10: 1,
            z11: 0,
            z12: 0,
          }

          assert_equal '0011111101000', Day24.binary_output(processed_wire_values)
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day24.big_example_input
          assert_equal 2024, Day24.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day24.personal_input
          assert_equal -1, Day24.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day24.big_example_input
          assert_equal -1, Day24.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day24.personal_input
          assert_equal -1, Day24.new.part_two(personal_input)
        end
      end
    end
  end
end
