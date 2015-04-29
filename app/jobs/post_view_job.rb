class PostViewJob < ActiveJob::Base
  def perform(id)
    post = Post.find(id)
    post.view||=0
    post.view = post.view + 1
    post.save!
  end
end