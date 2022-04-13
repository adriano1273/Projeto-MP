# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'string' }
    email { 'asd@email' }
    password { '123456' }
    is_admin { false }
  end
end
