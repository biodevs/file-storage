# frozen_string_literal: true

FactoryBot.define do
  factory :directory do
    dirname { Faker::Name.name.parameterize.underscore }
    parent_id { nil }

    trait :with_document do
      after :create do |directory|
        create_list(:archive, 2, :with_document, directory:)
      end
    end

    trait :with_subdirectories do
      after :create do |dir|
        create_list(:directory, 3, parent_id: dir.id)
      end
    end
  end
end