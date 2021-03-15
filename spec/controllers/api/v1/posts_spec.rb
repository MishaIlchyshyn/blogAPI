require 'rails_helper'

describe Api::V1::PostsController, type: :controller do
  describe "GET /posts" do
    it 'returns all posts' do
      user = create(:user, email: 'user2@gmail.com', password: 'password')
      post1 = create(:post, title: 'title', body: 'body', category: 'category', user_id: user.id)
      post2 = create(:post, title: 'title1', body: 'body1', category: 'category1', user_id: user.id)

      get :index

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].size).to eq(2)
    end
  end

  describe "GET /posts/:id" do
    it "show a post" do
      user = create(:user, email: 'test@gmail.com', password: 'password')
      post1 = create(:post, id: 1, title: 'title', body: 'body', category: 'category', user_id: user.id)
      post2 = create(:post, id: 2, title: 'title1', body: 'body1', category: 'category1', user_id: user.id)

      get :show, params: { id: 1 }

      expect(JSON.parse(response.body)).to eq(post1.as_json(only: [:title, :body, :category, :created_at]))
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /posts" do
    it "create a new post" do
      user = create(:user, email: 'test@gmail.com', password: 'password', authentication_token: "123323115646")
      header = {"Authorization": "Bearer #{user.authentication_token}", "Accept": "application/json"}
      request.headers.merge!(header)

      expect {
        post :create, params: { post: { title: "test title", body: "test body", category: "test category", user_id: user.id } }
      }.to change { Post.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE /posts/:id" do
    it "delete a post" do
      user = create(:user, email: 'test@gmail.com', password: 'password', authentication_token: "123323115646")
      header = {"Authorization": "Bearer #{user.authentication_token}", "Accept": "application/json"}
      request.headers.merge!(header)
      post1 = create(:post, id: 1, title: 'title', body: 'body', category: 'category', user_id: user.id)
      post2 = create(:post, id: 2, title: 'title1', body: 'body1', category: 'category1', user_id: user.id)

      expect {
        delete :destroy, params: { id: 1 }
      }.to change { Post.count }.from(2).to(1)

      expect(response).to have_http_status(:ok)
    end
  end
end