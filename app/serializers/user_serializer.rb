class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_admin

  has_many :favorites
  has_many :ratings
end
