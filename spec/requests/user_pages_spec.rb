require 'spec_helper'

describe "User pages" do 
  subject { page }

  describe "profile page" do
    let(:user) { create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "sign up" do
    before { visit signup_path }

    let (:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "111111"
        fill_in "Confirmation", with: "111111"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        
        describe "edit" do
          before { visit edit_user_path(user) }

          describe "page" do
            it { should have_content("Update your profile") }
            it { should have_title("Edit user") }
            it { should have_link('change', href: 'http://gravatar.com/emails') }
          end

          describe "with invalid information" do
            before { click_button "Save change" }

            it { should have_content('error') }
          end
        end

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end      
    end
  end
end