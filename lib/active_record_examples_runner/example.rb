class ActiveRecordExamplesRunner::Example
  include ActiveRecordExamplesRunner::Renderer

  def initialize(name, &block)
    @name = name
    @block = block
  end

  def call
    render "Example: #{@name}", &@block
  end
end