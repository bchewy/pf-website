class Event < ApplicationRecord
  has_many :pictures, dependent: :destroy
  has_many :teams
  mount_uploader :event_banner, AttachmentUploader
  #mount_uploaders :event_pics, AttachmentUploader
  #serialize :event_pics, JSON

  # Event Attributes
  require 'uri'
  validates :eventName, presence: true, length: {maximum: 500, too_long: "%{count} characters is maximum allowed."}
  validates :eventNoOfPpl, presence: true, length: {minimum: 1, too_short: "%{count} person minimum..."}
  validates :eventNoTeams, presence: true, length: {minimum: 1, too_short: "%{count} person minimum..."}
  validates :eventAdminEmail, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP, message: "Only valid emails."}

  # Event Pictures
  validates :event_banner, presence: true
  #validates :event_pics, presence: true


end
