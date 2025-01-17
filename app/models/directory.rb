# frozen_string_literal: true

class Directory < ApplicationRecord
  include Dirtable

  belongs_to :parent, class_name: 'Directory', optional: true

  has_many :subdirectories, class_name: 'Directory', foreign_key: :parent_id, dependent: :destroy

  has_many :archives, dependent: :destroy
end
