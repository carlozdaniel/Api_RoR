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
    let!(:posts) { create_list(:post, 10, publisher:true) }
    #rspec {factory_bot} create list the 10 articles publisher
    it "should return all the publisher posts" do
      get '/posts'
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(post.size)
      expect(response).to have_http_status(200)
    end
  end


  describe "GET /post/{id}" do
    let(:post) { create(:post) }

    it "should return a post" do
      get "/posts/#{post.id}"

      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(post.id)

      expect(response).to have_http_status(200)
    end
  end
end