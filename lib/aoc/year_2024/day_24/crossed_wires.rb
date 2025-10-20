module Aoc
  module Year2024
    class Day24
      def self.small_example_input
        <<-INPUT.strip
          x00: 1
          x01: 1
          x02: 1
          y00: 0
          y01: 1
          y02: 0
          
          x00 AND y00 -> z00
          x01 XOR y01 -> z01
          x02 OR y02 -> z02
        INPUT
      end

      def self.big_example_input
        <<-INPUT.strip
          x00: 1
          x01: 0
          x02: 1
          x03: 1
          x04: 0
          y00: 1
          y01: 1
          y02: 1
          y03: 1
          y04: 1
  
          ntg XOR fgs -> mjb
          y02 OR x01 -> tnw
          kwq OR kpj -> z05
          x00 OR x03 -> fst
          tgd XOR rvg -> z01
          vdt OR tnw -> bfw
          bfw AND frj -> z10
          ffh OR nrd -> bqk
          y00 AND y03 -> djm
          y03 OR y00 -> psh
          bqk OR frj -> z08
          tnw OR fst -> frj
          gnj AND tgd -> z11
          bfw XOR mjb -> z00
          x03 OR x00 -> vdt
          gnj AND wpb -> z02
          x04 AND y00 -> kjc
          djm OR pbm -> qhw
          nrd AND vdt -> hwm
          kjc AND fst -> rvg
          y04 OR y02 -> fgs
          y01 AND x02 -> pbm
          ntg OR kjc -> kwq
          psh XOR fgs -> tgd
          qhw XOR tgd -> z09
          pbm OR djm -> kpj
          x03 XOR y03 -> ffh
          x00 XOR y04 -> ntg
          bfw OR bqk -> z06
          nrd XOR fgs -> wpb
          frj XOR qhw -> z04
          bqk OR frj -> z07
          y03 OR x01 -> nrd
          hwm AND bqk -> z03
          tgd XOR rvg -> z12
          tnw OR pbm -> gnj
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      module GateTypes
        AND = 'and'.to_sym.freeze
        XOR = 'xor'.to_sym.freeze
        OR = 'or'.to_sym.freeze

        ALL = constants.map { |c| const_get(c) }.freeze
      end

      Gate = Data.define(:operand, :a, :b)

      def parse(input)
        initial_wire_input, gates_input = input.strip.split(/\n\s*\n/, 2).map(&:strip)

        initial_wire_values = initial_wire_input.lines.each_with_object({}) do |wire, wire_values|
          indicator_input, value_input = wire.strip.split(': ', 2)

          wire_values[indicator_input.to_sym] = value_input.to_i
        end

        gates = gates_input.strip.lines.each_with_object({}) do |gate, gates|
          first, operand, second, to = gate.match(/(\w+) (OR|AND|XOR) (\w+) -> (\w+)/)[1, 4]
          gates[to.to_sym] = Gate[operand.downcase.to_sym, first.to_sym, second.to_sym]
        end

        {
          initial_wire_values: initial_wire_values,
          gates: gates
        }
      end

      def self.process_gates(initial_wire_values, gates)
        wire_values = initial_wire_values.transform_values { |value| value == 1 }

        next_output_wires, future_output_wires = gates.keys.partition do |output_wire|
          wire_values.key?(gates[output_wire].a) && wire_values.key?(gates[output_wire].b)
        end

        # puts next_output_wires.inspect

        while next_output_wires.any?
          next_output_wires.map do |output_wire|
            [output_wire, gates[output_wire]]
          end.each do |output_wire, gate|
            unless wire_values.key?(gate.a) && wire_values.key?(gate.b)
              raise StandardError.new("Gate #{gate.a} or #{gate.b} not yet defined")
            end

            # puts "output_wire: " + output_wire.to_s + '   ' + gate.to_s
            # puts "value before: " + wire_values.fetch(output_wire, nil).inspect

            wire_values[output_wire] = case gate.operand
                                       when GateTypes::AND
                                         wire_values[gate.a] && wire_values[gate.b]
                                       when GateTypes::OR
                                         wire_values[gate.a] || wire_values[gate.b]
                                       when GateTypes::XOR
                                         [wire_values[gate.a], wire_values[gate.b]].one?
                                       else
                                         raise StandardError.new("No such operand #{gate.operand}")
                                       end

            # puts "value after: " + wire_values.fetch(output_wire, nil).inspect
          end

          next_output_wires, future_output_wires = future_output_wires.partition do |output_wire|
            wire_values.key?(gates[output_wire].a) && wire_values.key?(gates[output_wire].b)
          end
        end

        wire_values.transform_values { |value| value ? 1 : 0 }
      end

      def self.binary_output(processed_wire_values, indicator: 'z')
        processed_wire_values.keys.filter do |key|
          key.to_s[0] == indicator
        end.sort.reverse.map do |output_wire|
          processed_wire_values[output_wire]
        end.map(&:to_s).join('')
      end

      def self.numbers(initial_wire_values)
        x = Day24.binary_output(initial_wire_values, indicator: 'x').to_i(2)
        y = Day24.binary_output(initial_wire_values, indicator: 'y').to_i(2)
        {
          x: x,
          y: y,
          answer: x + y
        }
      end

      def part_one(input)
        parsed = parse(input)
        initial_wire_values = parsed[:initial_wire_values]
        gates = parsed[:gates]

        processed_wire_values = Day24.process_gates(initial_wire_values, gates)

        output = Day24.binary_output(processed_wire_values)
        output.to_i(2)
      end

      def part_two(input)
        parsed = parse(input)

        nil
      end
    end
  end
end
