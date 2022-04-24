class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_admin, :email, :authentication_token

  has_many :favorites
  has_many :ratings
end
