module Aoc
  module Year2024
    class Day13
      def self.example_input
        <<-INPUT.strip
          Button A: X+94, Y+34
          Button B: X+22, Y+67
          Prize: X=8400, Y=5400
          
          Button A: X+26, Y+66
          Button B: X+67, Y+21
          Prize: X=12748, Y=12176
          
          Button A: X+17, Y+86
          Button B: X+84, Y+37
          Prize: X=7870, Y=6450
          
          Button A: X+69, Y+23
          Button B: X+27, Y+71
          Prize: X=18641, Y=10279
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      ClawMachine = Data.define(:ax, :ay, :bx, :by, :prize_x, :prize_y)
      CLAW_MACHINE_REGEX = /Button A: X\+(\d+), Y\+(\d+)\n\s*Button B: X\+(\d+), Y\+(\d+)\n\s*Prize: X=(\d+), Y=(\d+)/

      def parse(input)
        input.strip.split(/\n\s*\n/).map do |claw_machine|
          ax, ay, bx, by, prize_x, prize_y = claw_machine.strip.match(CLAW_MACHINE_REGEX)[1..6].map(&:to_i)
          ClawMachine[ax: ax, ay: ay, bx: bx, by: by, prize_x: prize_x, prize_y: prize_y]
        end
      end

      Equation = Struct.new(:a, :b, :ans)

      def find_solution_to_claw_machine(claw_machine)
        x = Equation.new(*[claw_machine.ax, claw_machine.bx, claw_machine.prize_x].map{|value| value * claw_machine.by })
        y = Equation.new(*[claw_machine.ay, claw_machine.by, claw_machine.prize_y].map{|value| value * claw_machine.bx })

        cancelling_out_b = Equation.new(x.a - y.a, x.b - y.b, x.ans - y.ans)
        a = cancelling_out_b.ans / cancelling_out_b.a

        b = (x.ans - x.a * a)/x.b

        return false unless a * claw_machine.ax + b * claw_machine.bx == claw_machine.prize_x && a * claw_machine.ay + b * claw_machine.by == claw_machine.prize_y

        [a, b]
      end

      def part_one(input)
        claw_machines = parse(input)

        claw_machines.sum do |claw_machine|
          a, b = find_solution_to_claw_machine(claw_machine)

          next 0 if a == false
          a * 3 + b
        end
      end

      def part_two(input)
        claw_machines = parse(input)

        claw_machines = claw_machines.map do |claw_machine|
          ClawMachine[
            ax: claw_machine.ax,
            ay: claw_machine.ay,
            bx: claw_machine.bx,
            by: claw_machine.by,
            prize_x: claw_machine.prize_x + 10_000_000_000_000,
            prize_y: claw_machine.prize_y + 10_000_000_000_000
          ]
        end

        claw_machines.sum do |claw_machine|
          a, b = find_solution_to_claw_machine(claw_machine)

          next 0 if a == false
          a * 3 + b
        end
      end
    end
  end
end
