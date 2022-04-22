class UserSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :favorites
  has_many :ratings
end
