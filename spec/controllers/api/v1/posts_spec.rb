require 'rails_helper'

describe Api::V1::PostsController, type: :controller do
  context 'when we need token' do
    before do
      @user = create(:user, email: 'testgmail@gmail.com', password: 'password')
      header = {"Authorization": "Bearer #{@user.authentication_token}", "Accept": "application/json"}
      request.headers.merge!(header)
    end

    it "create a new post" do
      expect {
        post :create, params: { post: { title: "test title", body: "test body", category: "test category", user_id: @user.id } }
      }.to change { Post.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end

    it "delete a post" do
      post1 = create(:post, title: 'title', body: 'body', category: 'category', user_id: @user.id)
      post2 = create(:post, title: 'title1', body: 'body1', category: 'category1', user_id: @user.id)

      expect {
        delete :destroy, params: { id: post1.id }
      }.to change { Post.count }.from(2).to(1)

      expect(response).to have_http_status(:ok)
    end
  end

  context 'when we do not need token' do
    before do
      @user = create(:user, email: 'testgmail@gmail.com', password: 'password')
    end

    it 'returns all posts' do
      post1 = create(:post, title: 'title', body: 'body', category: 'category', user_id: @user.id)
      post2 = create(:post, title: 'title1', body: 'body1', category: 'category1', user_id: @user.id)

      get :index

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].size).to eq(2)
    end

    it 'returns 0 if we not have posts' do
      get :index

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].size).to eq(0)
    end

    it 'returns 0 if we not have posts' do
      get :index

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].size).to eq(0)
    end

    it "show a post" do
      post1 = create(:post, title: 'title', body: 'body', category: 'category', user_id: @user.id)
      post2 = create(:post, title: 'title1', body: 'body1', category: 'category1', user_id: @user.id)

      get :show, params: { id: post1.id }

      expect(JSON.parse(response.body)).to eq(post1.as_json(only: [:title, :body, :category, :created_at]))
      expect(response).to have_http_status(:ok)
    end
  end
end