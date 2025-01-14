# frozen_string_literal: true

module ArchiveInteraction
  class Create < BaseInteraction
    file :document
    string :directory_id

    validate :content_size_invalid, if: -> { document.size > Documentable::CONTENT_SIZE }

    def execute
      create_archive
    end

    private

    def create_archive
      within_transaction do
        Archive.create!(directory_id:, document: file_blob)
      end
    end

    def file_blob
      ActiveStorage::Blob.create_and_upload!(
        io: document,
        filename: File.basename(document.path, '.*'),
        content_type: File.extname(document.path)
      )
    end

    def content_size_invalid
      errors.add(:base, :content_size_invalid, content_size: Documentable::CONTENT_SIZE / 1_000_000)
    end
  end
end
