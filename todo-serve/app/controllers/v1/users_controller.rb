class V1::UsersController < V1::BaseController
  skip_before_filter :verify_authenticity_token, :only => [:send_phone, :verify_pin]

  include ApplicationHelper
  api :POST, "/users/send", "Create an user by phone"

  param :phone, String, :required => true, :desc => "+84935118429"

  example "
    Request (application/json)
    {
      'phone': '+84935118429'
    }

    Response:
    success 201
    {
      'status': 'Sended pin code'
    }

    error 401
    {
      'status': 'phone number is in valid'
    }
  "

  def send_phone
    @user = User.find_or_create_by(phone: _phone_params[:phone])
    @user.generate_pin
    _send_pin_code(@user.pin, @user.phone)
  end

  api :POST, "/users/verify", "Verify phone"

  param :phone, String, :required => true, :desc => "+84935118429"
  param :pin, String, :required => true, :desc => "1234"

  example "
    Request (application/json)
      {
        'phone': '+84935118429',
        'pin': '9070'
      }

    Response:
      Success 201
      {
        'id': 9,
        'profile': null
      }

      Error 422
      Update is success but any condition make it can not save
      {
        'errors': 'Connection is errors'
      }

      Error 404
      Phone number is exist but Phone number and pin code is not consitent to update
      {
        'errors': 'Phone number and pin code is not consitent'
      }

      Error 401
      Phone number is not exist
      {
        'errors': 'Phone number is not exist'
      }
    "

  def verify_pin
    @user = User.find_by(phone: _verify_phone_params[:phone])
    if @user.present?
      if @user.verified?(_verify_phone_params[:pin])
        @user.verified(_verify_phone_params[:pin])
        render json: @user, status: 201
      else
        render json: { errors: "Phone number and pin code is not consitent" }, status: 404
      end
    else
      render json: { errors: "Phone number is not exist" }, status: 401
    end
  end

  private

  def _send_pin_code(pin, phone)
    begin
      twilio_client.messages.create(
        to: phone,
        from: ENV['TWILIO_PHONE_NUMBER'],
        body: "Your pin code to verify is #{pin}"
      )
      render json: { messages: 'sent pin code' }, status: 201
    rescue
      puts "===============#{phone} phone number is not exist==============="
      render json: { errors: 'phone number is not exist' }, status: 401
    end
  end

  def _phone_params
    params.permit(:phone)
  end

  def _verify_phone_params
    params.permit(:phone, :pin)
  end

end
