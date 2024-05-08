module FileSizeValidator
  extend ActiveSupport::Concern
  # good use of concern
  included do
    validate :validate_file_sizes
  end

  private

  def validate_file_sizes
    max_file_size = 10.megabytes
    all_attachments = [avatar, *additional_files, *additional_files_2, *additional_files_3].compact

    all_attachments.each do |file|
      if file.attached? && file.blob.byte_size > max_file_size
        errors.add(:base, "#{file.filename} is too large. Maximum file size allowed is 10 MB.")
      end
    end
  end
end
