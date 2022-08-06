# frozen_string_literal: true

require "securerandom"
require "active_support/all"
require "active_record"
require "ffaker"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module ActiveRecordExamplesRunner
  class Error < StandardError; end

  def self.run_file(path)
    code = File.read(path)
    runner = FileRunner.new(path) { eval(code) }
    runner.setup.run.destroy
  end
end
