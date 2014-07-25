class PostsController < ApplicationController
  before_action :login_required, :except => [:index, :reading_version]
  before_action :find_post, :only => [:show, :update, :destroy]

  def index
    @posts = Post.all

    render json: @posts
  end

  def create
    @post = current_user.posts.new(post_params) 
    @post.url = extract_first_url(@post.url)

    if @post.save
      render json: { message: "文章發佈成功！", success: true }
    else
      render json: { message: "文章發佈失敗！可能是網址與其他篇重複或漏打了什麼！", success: false }
    end
  end

  def user_posts
    @posts = current_user.posts

    render json: @posts
  end

  def show
    render json: @post
  end

  def reading_version
   @post = Post.find(params[:id])
   render json: custom_json_for(@post.reading_version)
  end

  def update
    if @post.update_attributes(post_params)
      render json: custom_json_for_update(@post, { message: "更新成功！", success: true })
    else
      render json: custom_json_for_update(@post, { message: "更新失敗！", success: false })
    end
  end

  def destroy
    @post.destroy!
    
    render json: { message: "刪除成功！", success: true }
  end

  private

  def post_params
    params.require(:post).permit(:url, :title, :description)
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end

	def extract_first_url(urls)
		urls = URI.extract(urls)

		return urls.first
	end

  def custom_json_for(post)
    hash_for_customized_json = build_hash_from_copying_every_attributes_of(post)

    hash_for_customized_json[:author_name] = post.author.name
    hash_for_customized_json[:author_image] = post.author.image

    hash_for_customized_json.to_json
  end

  def custom_json_for_update(post, opts = {})
    hash_for_customized_json = build_hash_from_copying_every_attributes_of(post)

    opts.each do |key, value|
      hash_for_customized_json[key] = value
    end

    hash_for_customized_json.to_json
  end

  def build_hash_from_copying_every_attributes_of(post)
    hash = {}

    post.attributes.each do |attr_name, attr_value|
     hash[attr_name] = post[attr_name]
    end

    hash 
  end
end
