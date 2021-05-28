class PostsController < ApplicationController
  #get /post
  def index
    @post = Post.where(published: true)
    render json: @posts, status: :ok
  end
  #get /posts/{id}
  def show
    @post = Post.find(params[:id])

  end
end