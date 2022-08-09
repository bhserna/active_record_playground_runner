module ActiveRecordPlaygroundRunner
  class Example
    include Renderer

    def initialize(name, &block)
      @name = name
      @block = block
    end

    def call
      render "Example: #{@name}", &@block
    rescue StandardError => e
      puts
      puts "Error in example:"
      puts e
    end
  end
end