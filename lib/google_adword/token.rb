module GoogleAdword::Token
  LENGTH = 32

  def generate
    SecureRandom.hex LENGTH
  end

  module_function :generate
end
