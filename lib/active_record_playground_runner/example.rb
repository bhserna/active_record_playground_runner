module ActiveRecordPlaygroundRunner
  class Example
    include Renderer

    def initialize(index, name, &block)
      @index = index
      @name = name
      @block = block
    end

    def call
      render "Example: #{@name || @index}", &@block
    rescue StandardError => e
      puts
      puts "Error in example:"
      puts e
    end
  end
end