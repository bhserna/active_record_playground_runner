# Active Record Playground Runner

A tool for to run active record examples.

This will help you play with Active Record and Postgres, without the thinking in the database setup.

You will be able to declare, schema, models, seeds and examples it just one file, like this:


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

For my ebook [Avoid n+1 queries on rails](https://bhserna.com/avoid-n-plus-1-queries-on-rails.html) I prepared a set of examples for each chapter using the first version of my [Active Record Playground](https://github.com/bhserna/active_record_playground), it was a template to help in the setup of an environment with Active Record.

But is hard to write a lot of examples with the same database schema, and is hard to setup a project for each schema.

With this tool I would be able to create examples with different schemas without setting up a project directory. Making it easier for me to create more and more diverse examples. And also helping the students to focus just on the thing they want to learn instead of the project setup.

## Installation

Add this line to your project's Gemfile:

```ruby
gem 'active_record_playground_runner'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_record_playground_runner

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then, run `bin/run_playground examples/00_example.rb` to run test example.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bhserna/active_record_playground_runner.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
