module Api
  class PostsController < ApiController
    before_action :load_post, only: [:update, :destroy]
    around_action :wrap_in_stale, only: [:show, :edit]
    before_action :build_post, only: [:create, :update]

    def index
      if stale?(load_posts)
        render json: @posts, each_serializer: Index::PostSerializer
      end
    end

    def show
      render json: @post
    end

    def create
      if @post.save
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
      @posts ||= Post.unscoped.full_text_search(params[:keywords]).order(updated_at: :desc).page params[:page]
    end

    def load_post
      @post ||= Post.unscoped.find(params[:id])
    end

    def build_post
      @post ||= Post.new
      @post.attributes = post_params
    end

    def post_params
      post_params = params[:post]
      post_params ? post_params.permit([:title, :body]) : {}
    end

    def wrap_in_stale
      if stale?(load_post)
        yield
      end
    end
  end
end