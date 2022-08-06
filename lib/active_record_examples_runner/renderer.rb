module ActiveRecordExamplesRunner::Renderer
  def render(title, &block)
    puts
    puts title
    puts "-" * title.length
    block.call
    puts 
  end
end