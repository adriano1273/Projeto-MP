# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :is_admin, inclusion: [false, true], exclusion: [nil]

  has_many :ratings
  has_many :favorites
end
