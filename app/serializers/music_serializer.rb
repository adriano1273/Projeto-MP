# frozen_string_literal: true

class MusicSerializer < ActiveModel::Serializer
  attributes :title, :description, :photo_url, :id, :average
  has_many :ratings

  def photo_url
    Rails.application.routes.url_helpers.rails_blob_path(object.photo, only_path: true) if object.photo.attached?
  end
end
