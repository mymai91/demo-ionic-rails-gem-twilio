require 'spec_helper'

describe V1::UsersController, type: :controller do

  describe '#send_phone' do
    it 'valid phone number' do
      post :send_phone, { phone: "+84935118429" }

      should respond_with 201
    end

    it 'invalid phone number' do
      post :send_phone, { phone: "1111111111" }

      should respond_with 401
    end
  end

  describe '#verify_pin' do
    before do
      @valid_use = User.create(phone: "+84935118429", pin: "1234")
      @invalid_user = User.create(phone: "+84935118429", pin: "1111")
    end

    it 'phone number and pin code is consitent' do
      user = @valid_use
      pin = user[:pin]
      post :verify_pin, { phone: "+84935118429", pin: pin }

      should respond_with 201
    end

    it 'phone number and pin code is not consitent' do
      user = @invalid_user
      post :verify_pin, { phone: "+84935118429", pin: "11111111" }

      should respond_with 404
    end

    it 'phone number is not exist' do
      user = @valid_use
      post :verify_pin, { phone: "+11111111111", pin: "11111111" }

      should respond_with 401
    end
  end
end
