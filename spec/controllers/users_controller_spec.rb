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
end
