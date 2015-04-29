class PostsController < ApplicationController
  def index
    @posts = Post.page params[:page]
    @top_posts = Post.order(view: :desc).limit(3)
  end

  def show
    @post = Post.find(params[:id])
    @img_top = @post.preview_url
  end


  def view
    #Make it later to render as fast as possible
    PostViewJob.perform_later(params[:id])
    expires_now
    render nothing: true
  end
end
