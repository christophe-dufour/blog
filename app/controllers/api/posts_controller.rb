module Api
  class PostsController < ApiController
    before_action :load_post, only: [:update, :destroy]
    around_action :wrap_in_stale, only: [:show, :edit]
    before_action :build_post, only: [:create, :update]

    def index
      if stale?(load_posts)
        render json: @posts
      end
    end

    def show
      render json: @post
    end

    def create
      if save_post
        render json: @post, status: 201
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    alias :update :create

    def destroy
      @post.destroy
      render nothing: true, status: 204
    end

    private

    def load_posts
      @posts ||= Post.unscoped.order(updated_at: :desc).where(name: "/.*#{params[:keywords]}.*/").page params[:page] unless params[:keywords].blank?
      @posts ||= Post.unscoped.order(updated_at: :desc).page params[:page]
    end

    def load_post
      @post ||= Post.find(params[:id])
    end

    def build_post
      @post ||= Post.new
      @post.attributes = post_params
    end

    def save_post
      if @post.save
        redirect_to @post
      end
    end

    def post_params
      post_params = params[:post]
      post_params ? post_params.permit([:title, :text]) : {}
    end

    def wrap_in_stale
      if stale?(load_post)
        yield
      end
    end
  end
end