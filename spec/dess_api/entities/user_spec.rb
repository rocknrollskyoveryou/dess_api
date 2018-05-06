require_relative '../../spec_helper'

describe User do
  let(:plain_attributes) { { email: 'antony@example.com', password: 'z1x2c3v4' } }
  let(:attributes) { Password.encrypt(plain_attributes) }

  it 'can be initialised with email and password' do
    user = User.new(attributes)
    user.email.must_equal 'antony@example.com'
  end

  it '.password returns the encrypted value' do
    user = User.new(attributes)
    user.password.wont_equal 'z1x2c3v4'
  end
end
