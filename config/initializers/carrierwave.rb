CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage :file
    config.asset_host = 'http://localhost:3000'
  else
    config.fog_credentials = {
      provider:                         'Google',
      google_storage_access_key_id:     'secretkeyid',
      google_storage_secret_access_key: 'secretaccesskey'
    }
    config.fog_directory = 'yourconfig.appspotdirectory.com'
  end
end
# Can be found in GCP > Storage > Browser
