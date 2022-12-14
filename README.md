# Active Record Playground Runner

A tool for to run active record examples.

This will help you play with Active Record and Postgres, without the thinking in the database setup.

You will be able to declare, schema, models, seeds and examples in just one file, like this:


```ruby
schema do
  create_table :posts do |t|
    t.string :title
    t.text :body
  end

  create_table :comments do |t|
    t.text :body
    t.integer :post_id
  end

  add_index :comments, :post_id
end

models do
  class Post < ActiveRecord::Base
    has_many :comments
  end

  class Comment < ActiveRecord::Base
    belongs_to :post
  end
end

seeds do
  posts = create_list(Post, count: 10) do
    {
      title: FFaker::CheesyLingo.title,
      body: FFaker::CheesyLingo.paragraph
    }
  end

  create_list_for_each_record(Comment, records: posts, count: 20) do |post|
    {
      post_id: post.id,
      body: FFaker::CheesyLingo.sentence
    }
  end
end

example "first" do
  Post.includes(:comments).limit(5).map do |post|
    puts post.comments.count
  end
end

example "second" do
  Post.includes(:comments).limit(5).map do |post|
    puts post.comments.size
  end
end
```

And the run it with:

```
bundle exec run_playground file_name.rb
```

And it will:

* Create the database with a random name
* Load the schema
* Run the seeds
* Run the examples with a nice format and with the logger turned on.
* Drop the database

## Why this tool?

I prepared a lot of examples for the ebook [Avoid n+1 queries on rails](https://bhserna.com/avoid-n-plus-1-queries-on-rails.html) using the first version of my [Active Record Playground](https://github.com/bhserna/active_record_playground). A template to help in the setup of an environment with Active Record.

With the old template it was is hard to write a lot of examples with the same database schema, and it was hard to setup a project for each schema.

With this tool is much more easier to create examples with different schemas because you don't need to setup a whole project directory for each schema.

It makes it easier to create more and more diverse examples. And also helping the people that see the examples to focus just on the example code instead of the project setup.
 
## Installation

Add this line to your project's Gemfile:

```ruby
gem 'active_record_playground_runner', "~> 0.1.0", github: "bhserna/active_record_playground_runner", branch: "main"
```

And then execute:

    $ bundle install
   

## How to use it

Read more on: https://bhserna.com/active-record-playground-runner-introduction.html

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then, run `bin/run_playground examples/00_example.rb` to run test example.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bhserna/active_record_playground_runner.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
