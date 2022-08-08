class ActiveRecordPlaygroundRunner::Example
  include ActiveRecordPlaygroundRunner::Renderer

  def initialize(name, &block)
    @name = name
    @block = block
  end

  def call
    render "Example: #{@name}", &@block
  end
end