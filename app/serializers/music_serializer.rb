class MusicSerializer < ActiveModel::Serializer
  attributes :title, :description, :photo_url, :id, :average
  has_many :ratings

  def photo_url
    if object.photo.attached?
      Rails.application.routes.url_helpers.rails_blob_path(object.photo, only_path: true)
    else
      nil
    end
  end
end
