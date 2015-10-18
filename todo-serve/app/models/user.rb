class User < ActiveRecord::Base
  def generate_pin
    self.pin = rand(0000..9999).to_s.rjust(4, "0")
    save
  end

  # Update status verify
  def verified(pin)
    update(verify: true) if verified?(pin)
  end

  def verified?(pin)
    self.pin == pin
  end
end
