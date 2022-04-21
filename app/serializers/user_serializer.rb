class UserSerializer < ActiveModel::Serializer
  attributes :id

  has_many :favorites
  has_many :ratings
end
