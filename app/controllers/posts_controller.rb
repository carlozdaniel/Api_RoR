 class PostsController < ApplicationController
  #get /post
  def index
    @posts = Post.where(published: true)
    render json: @posts, status: :ok
  end
  #get /posts/{id}
  def show
    @post = Post.find(params[:id])
    render json: @post, status: :ok
  end
end