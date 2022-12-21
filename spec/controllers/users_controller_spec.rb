require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    # pending "add some examples (or delete) #{__FILE__}"
    it "renders the users index" do
         get :index
        expect(response).to render_template(:index)
        end
    end

    describe "GET #new" do
        it "brings up the new forum" do
            allow(subject).to receive(:logged_in?).and_return(true)
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe "POST #create" do 
        before :each do 
            create(:joseph)
            allow(subject).to receive(:current_user).and_return(User.last)
        end
        let(:valid_params){ {user: {username: 'Joseph'}} }
        let(:invalid_params){ {user: {nada: ''}}}
        context 'with valid params' do 
            it 'creates the user' do 
                post :create, params: valid_params
                expect(User.last.username).to eq('Joseph')
            end

            it 'redirects to user\'s show page' do 
                post :create, params: valid_params 
                expect(response).to redirect_to(user_url(User.last.id))
            end
        end
        context 'with invalid params' do 
            before :each do 
                post :create, params: invalid_params 
            end

            it "renders new template" do 
                expect(response).to render_template(:new)
            end

            it "adds errors to flash" do 
                expect(flash[:errors]).to be_present
            end
        end
    end
end
