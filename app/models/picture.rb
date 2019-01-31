class Picture < ApplicationRecord
  belongs_to :event
  mount_uploaders :event_pics, AttachmentUploader
  serialize :event_pics, JSON
end
