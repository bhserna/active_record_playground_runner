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
end
