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
    { title: FFaker::CheesyLingo.title, body: FFaker::CheesyLingo.paragraph }
  end

  create_list_for_each_record(Comment, records: posts, count: 20) do |post|
    { post_id: post.id, body: FFaker::CheesyLingo.sentence }
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