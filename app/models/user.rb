class User < ApplicationRecord
  def self.parse_user(user_object)
    @user = User.new(
      token: user_object['token'], 
      first_name: user_object['first_name']
    )

    @user
  end
end
