class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
          name: auth.extra.raw_info.name,
          first_name: auth.extra.raw_info.first_name,
          last_name: auth.extra.raw_info.last_name,
          gender: auth.extra.raw_info.gender,
          birthday: auth.extra.raw_info.birthday,
          provider: auth.provider,
          uid: auth.uid,
          email: auth.extra.raw_info.email,
          image_url: auth.info.image,
          password: Devise.friendly_token[0, 20]
       )
      user.skip_confirmation!
      binding.pry
      user.save(validate: false)
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

end
