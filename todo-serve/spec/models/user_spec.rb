require 'spec_helper'

describe User do
  describe '#generate_pin' do
    it 'generate a pin code' do
      user = User.create(phone: "+84935118429")
      user.generate_pin
      pin = user[:pin]
      length_of_pin = pin.length

      expect(pin).not_to be_nil
      expect(length_of_pin).to eq(4)
    end
  end

  describe '#verified?' do
    let(:user) { User.create(phone: "+84935118429") }

    context 'valid pin' do
      it 'return true' do
        valid_pin = user[:pin]

        expect(user.verified?(valid_pin)).to be_truthy
      end
    end

    context 'not valid pin' do
      it 'return false' do
        invalid_pin = 11111

        expect(user.verified?(invalid_pin)).to be_falsey
      end
    end
  end

  describe '#verified' do
    let(:user) { User.create(phone: "+84935118429") }

    context 'valid pin' do
      it 'verify change from false to true' do
        valid_pin = user[:pin]

        expect do
          user.verified(valid_pin)
        end.to change{user[:verify]}.from(false).to(true)
      end
    end

    context 'not valid pin' do
      it 'verify do not change from false to true' do
        invalid_pin = 11111

        expect do
          user.verified(invalid_pin)
        end.to_not change{user[:verify]}
      end
    end
  end
end
