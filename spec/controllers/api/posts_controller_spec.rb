require 'rails_helper'

describe Api::PostsController, :type => :controller do
  before { request.session[:admin] = :ok }
  describe "index" do
    before do
      FactoryGirl.create(:post, title: 'Baked Potato w/ Cheese')
      FactoryGirl.create(:post, title: 'Garlic Mashed Potatoes')
      FactoryGirl.create(:post, title: 'Potatoes Au Gratin')
      FactoryGirl.create(:post, title: 'Baked Brussel Sprouts')

      xhr :get, :index, format: :json, keywords: keywords

    end

    subject(:results) { JSON.parse(response.body) }

    def extract_title
      ->(object) { object["title"] }
    end

    context "when the search finds results" do
      let(:keywords) { 'Baked' }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return two results' do
        expect(results.size).to eq(2)
      end
      it "should include 'Baked Potato w/ Cheese'" do
        expect(results.map(&extract_title)).to include('Baked Potato w/ Cheese')
      end
      it "should include 'Baked Brussel Sprouts'" do
        expect(results.map(&extract_title)).to include('Baked Brussel Sprouts')
      end
    end

    context "when the search doesn't find results" do
      let(:keywords) { 'foo' }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end


    context "when there is no keyword at all" do
      let(:keywords) { nil }
      it "should include 'Baked Potato w/ Cheese'" do
        expect(results.map(&extract_title)).to include('Baked Potato w/ Cheese')
      end
      it "should include 'Baked Brussel Sprouts'" do
        expect(results.map(&extract_title)).to include('Baked Brussel Sprouts')
      end
      it "should include 'Potatoes Au Gratin'" do
        expect(results.map(&extract_title)).to include('Potatoes Au Gratin')
      end
      it "should include 'Garlic Mashed Potatoes'" do
        expect(results.map(&extract_title)).to include('Garlic Mashed Potatoes')
      end
    end
  end


  describe "show" do
    let(:a_post) { FactoryGirl.create(:post) }
    let(:a_published_post) { FactoryGirl.create(:published_post) }
    subject(:result) { JSON.parse(response.body) }

    it "should get a published post" do
      xhr :get, :show, format: :json, id: a_published_post.id
      expect(result['title']).to eq a_published_post.title
      expect(result['body']).to eq a_published_post.body
    end
    it "should get an unpublished post" do
      xhr :get, :show, format: :json, id: a_post.id
      expect(result['title']).to eq a_post.title
    end
    it "should get a 404" do
      xhr :get, :show, format: :json, id: -1
      expect(response).to have_http_status(404)
    end
  end


  describe "create" do
    it "should not create a post without values" do
      expect { xhr :post, :create, format: :json }.to change { Post.unscoped.count }.by(0)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should create a post" do
      expect { xhr :post, :create, format: :json, post: FactoryGirl.attributes_for(:post) }.to change { Post.unscoped.count }.by(1)
      expect(response).to have_http_status(201)
    end
  end


  describe "update" do
    let(:a_post) { FactoryGirl.create(:post) }
    subject(:result) { JSON.parse(response.body) }
    it "should set the post title" do
      new_title = Faker::Lorem.sentence
      xhr :patch, :update, format: :json, id: a_post.id, post: {title: new_title}
      expect(response).to have_http_status(201)
      expect(result['title']).to eq(new_title)
    end
  end


  describe "destroy" do
    let(:a_post) { FactoryGirl.create(:post) }
    subject(:result) { JSON.parse(response.body) }
    it "should remove the post from database" do
      #Call to make it created out of expect change count. How to make it clear?
      a_post
      expect { xhr :delete, :destroy, format: :json, id: a_post.id }.to change { Post.unscoped.count }.by(-1)
      expect(response).to have_http_status(204)
    end
  end


end