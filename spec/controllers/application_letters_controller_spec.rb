require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ApplicationLettersController, type: :controller do

  let(:valid_attributes) { FactoryGirl.build(:application_letter).attributes.merge(status: :pending) }

  let(:invalid_attributes) { FactoryGirl.build(:application_letter, event_id: nil).attributes.merge(status: :pending)}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ApplicationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end

  context "with an existing application letter" do
    before :each do
      @application = ApplicationLetter.create! valid_attributes
      sign_in @application.user
    end
    describe "GET #index" do
      it "assigns all applications as @applications" do
        get :index
        expect(assigns(:application_letters)).to eq([@application])
      end
    end

    describe "GET #show" do
      it "assigns the requested application as @application" do
        get :show, id: @application.to_param
        expect(assigns(:application_letter)).to eq(@application)
      end
      it "assigns selectable statuses" do
        get :show, id: @application.to_param
        expect(assigns(:selectable_statuses)).to eq([:pre_accepted,:rejected,:pending,:alternative])
      end
    end

    describe "GET #edit" do
      it "assigns the requested application as @application" do
        get :edit, id: @application.to_param, session: valid_session
        expect(assigns(:application_letter)).to eq(@application)
      end
    end

    describe "GET #check" do
      it "assigns the requested application as @application" do
        get :check, id: @application.to_param, session: valid_session
        expect(assigns(:application_letter)).to eq(@application)
      end

      it "assigns the application deadline status as @application_deadline_exceeded" do
        get :check, id: @application.to_param, session: valid_session
        expect(assigns(:application_deadline_exceeded)).to eq(@application.after_deadline?)
      end
    end

    describe "GET #new" do
      it "assigns a new application as @application" do
        get :new, session: valid_session
        expect(assigns(:application_letter)).to be_a_new(ApplicationLetter)
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
              grade: 10,
              experience: "None",
              motivation: "None",
              coding_skills: "None",
              emergency_number: "01234567891",
              vegetarian: true,
              vegan: true,
              allergic: true,
              allergys: "Many"
          }
        }

        it "updates the requested application" do
          put :update, id: @application.to_param, application_letter: new_attributes, session: valid_session
          @application.reload
          expect(@application.motivation).to eq(new_attributes[:motivation])
        end

        it "assigns the requested application as @application" do
          put :update, id: @application.to_param, application_letter: valid_attributes, session: valid_session
          expect(assigns(:application_letter)).to eq(@application)
        end

        it "redirects to application checking page" do
          put :update, id: @application.to_param, application_letter: valid_attributes, session: valid_session
          expect(response).to redirect_to(check_application_letter_path(@application))
        end
      end

      context "with invalid params" do
        it "assigns the application as @application" do
          put :update, id: @application.to_param, application_letter: invalid_attributes, session: valid_session
          expect(assigns(:application_letter)).to eq(@application)
        end

        it "re-renders the 'edit' template" do
          put :update, id: @application.to_param, application_letter: invalid_attributes, session: valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "PUT #update_status" do
      before :each do
        sign_in FactoryGirl.create(:user, role: :admin)
      end
      context "with valid params" do
        let(:new_status) { {status: 'pre_accepted'} }

        it "assigns the requested application as @application" do
          put :update_status, id: @application.to_param, application_letter: new_status, session: valid_session
          expect(assigns(:application_letter)).to eq(@application)
        end

        it "updates the status" do
          put :update_status, id: @application.to_param, application_letter: new_status, session: valid_session
          @application.reload
          expect(@application.status).to eq(new_status[:status])
        end

        it "redirects back" do
          put :update_status, id: @application.to_param, application_letter: new_status, session: valid_session
          expect(response).to redirect_to(request.env['HTTP_REFERER'])
        end
      end

      context "with invalid params" do
        it "assigns the application as @application" do
          put :update_status, id: @application.to_param, application_letter: {status: nil}, session: valid_session
          expect(assigns(:application_letter)).to eq(@application)
        end

        it "re-renders the 'edit' template" do
          put :update_status, id: @application.to_param, application_letter: {status: nil}, session: valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested application" do
        expect {
          delete :destroy, id: @application.to_param, session: valid_session
        }.to change(ApplicationLetter, :count).by(-1)
      end

      it "redirects to the applications list" do
        delete :destroy, id: @application.to_param, session: valid_session
        expect(response).to redirect_to(application_letters_url)
      end
    end
  end

  describe "POST #create" do
    before :each do
      sign_in FactoryGirl.create(:profile).user
    end
    context "with valid params" do
      it "creates a new Application" do
        expect {
          post :create, application_letter: valid_attributes, session: valid_session
        }.to change(ApplicationLetter, :count).by(1)
      end

      it "assigns a newly created application as @application" do
        post :create, application_letter: valid_attributes, session: valid_session
        expect(assigns(:application_letter)).to be_a(ApplicationLetter)
        expect(assigns(:application_letter)).to be_persisted
      end

      it "redirects to the checking page for the created application" do
        post :create, application_letter: valid_attributes, session: valid_session
        expect(response).to redirect_to(check_application_letter_path(ApplicationLetter.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved application as @application_letter" do
        post :create, application_letter: invalid_attributes, session: valid_session
        expect(assigns(:application_letter)).to be_a_new(ApplicationLetter)
      end

      it "re-renders the 'new' template" do
        post :create, application_letter: invalid_attributes, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end
end
