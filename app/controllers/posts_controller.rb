class PostsController < ApplicationController
  def index
    @posts = Post.page params[:page]
    if stale?(@posts, public: true)
      @top_posts = Post.order(view: :desc).limit(3)
      expires_in 1.hour
    end
  end

  def show
    @post = Post.find(params[:id])
    if stale?(@post, public: true)
      @img_top = @post.preview_url
      expires_in 1.hour
    end
  end


  def view
    #Make it async to render as fast as possible
    PostViewJob.perform_later(params[:id])
    expires_now
    render nothing: true
  end
end
