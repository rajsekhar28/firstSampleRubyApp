require 'spec_helper'

describe User do
	before { @user = User.new(name: "Example user", email:"example@email.com", )}

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = "" }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = ' ' }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = "a"*51 }
		it { should_not be_valid }
	end

	describe "when email address is already taken" do
		before {
			user_with_same_mail = @user.dup
			user_with_same_mail.email = @user.email.upcase
			user_with_same_mail.save
		}

		it { should_not be_valid }
	end
end
