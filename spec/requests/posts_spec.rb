require "rails_helper"
require "byebug"
RSpec.describe "Posts", type: :request do

  describe "GET /posts" do
    before { get '/posts' }

    it "should return ok" do
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end
  end
 
  describe "with data in the DB" do
    let!(:posts) { create_list(:post, 10, published: true) }

    #rspec {factory_bot} create list the 10 articles publisher
    it "should return all the publisher posts" do
      get '/posts'
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(posts.size)
      expect(response).to have_http_status(200)
    end
  end


  describe "GET /post/{id}" do
    let!(:post) { create(:post) }

    it "should return a post" do
    get "/posts/#{post.id}"

      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(post.id)

      expect(response).to have_http_status(200)
    end
  end

  describe "POST /posts" do
    lef!(:user) { create(:user) }
    it "should create a post" do
      req_payload = {
        post: {
          title: 'titulo',
          content: 'content',
          published: true
        }
      }

      post "/posts", params: req_payload
      payload = JSON.parse(response.body)
      except(payload).to_not be_empty
      except(payload["id"]).to_not be_empty
      expect(response).to have_http_status(:create)
    end
  end

  describe "PUT /posts/{id}" do
    lef!(:article) { create(:post) }
    it "should create a post" do
      req_payload = {
        post: {
          title: 'titulo',
          content: 'content',
          published: false,
          user_id: 1
        }
      }
      #put
      put "/posts/#{article.id}", params: req_payload
      payload = JSON.parse(response.body)
      except(payload).to_not be_empty
      except(payload["id"]).to eq(article.id)
      expect(response).to have_http_status(:ok)
    end
  end
end