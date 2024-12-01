# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"

require File.join(File.dirname(__FILE__), "..", "lib", "aoc.rb")
