## How to run
[![CircleCI](https://circleci.com/gh/bchewy/RoRSite/tree/master.svg?style=svg&circle-token=9f4034f0b2cb346461a973a32c3957ae6eb52a3a)](https://circleci.com/gh/bchewy/RoRSite/tree/master)
<br>
Bootup postgresSQL server locally otherwise... revert to sq3lite in `database.yml`<br>
Run `bundle install` to install gems<br>
Run `rails server` to start<br>
Delete `.idea` if you're not using RubyMine... it might screw things up for you!
## Setup
Change the carrierwave.rb config file to your selected storage platform (ie: GCP, AWS S3.. Rackspace.. and more!)
<br>
Example for Google Storage (GCP)
```ruby
CarrierWave.configure do |config|
  if Rails.env.test? #Check if environment is test, otherwise
    config.storage :file
    config.asset_host = 'http://localhost:3000'
  else #saves the files into Google Storage
    config.fog_credentials = {
      provider:                         'Google',
      google_storage_access_key_id:     '<yourgooglestorageaccesskey>',
      google_storage_secret_access_key: '<yourgooglesecretaccesskey>'
    }
    config.fog_directory = '<theappspot-directory-google or s3 bucket.. etc>'
  end
end
```
Change firebase init function for major controllers (events,pictures,players & teams) as shown below for method init_firebase
```ruby
  def init_firebase
    firebase_url = "yourfirebase.io"
    firebase_secret = "yourfirebasesecrethere"
    Firebase::Client.new(firebase_url, firebase_secret)
  end
```
## Download version 1
.zip - https://github.com/bchewy/RoRSite/archive/v1.0.zip
.tar.gz - https://github.com/bchewy/RoRSite/archive/v1.0.tar.gz
## Debugging
Can't create any objects?:
`rails console` and do various commands like shown below, if output is as shown.. it's your rails/ruby!

```bash
2.5.3 :001 > event = Event.new
 => #<Event id: nil, eventName: nil, created_at: nil, updated_at: nil, event_banner: nil, eventAdminEmail: nil, eventNoOfPpl: nil, eventID: nil, eventNoTeams: nil> 
 
 2.5.3 :003 > event.pictures.build()
 => #<Picture id: nil, answers: nil, hints: nil, event_pics: nil, event_id: nil, created_at: nil, updated_at: nil> 

2.5.3 :004 > event.teams.build()
 => #<Team id: nil, name: nil, authcode: nil, event_id: nil, created_at: nil, updated_at: nil> 

```
Schema issues?:
`rails db:migrate:reset`should fix it. Make sure you delete content in `schema.rb` first before running this.<br><br>
Send a pull request if you've got something to suggest!


