class MusicSerializer < ActiveModel::Serializer
  attributes :title, :description, :photo
  has_many :ratings
end
