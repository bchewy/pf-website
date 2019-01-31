class EventsController < ApplicationController

  def index
    load_firebase
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    ep = event_params
    ep[:eventID] = generateEventID
    @event = Event.new(ep)
    if @event.save
      save_firebase(ep)
      redirect_to events_path, notice: "The event #{@event.eventName} has been uploaded."
    else
      render "new"
    end
  end

  #todo - Edit function to edit said event
  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      update_firebase(event_params)
      redirect_to events_path, notice: "Event #{@event.eventName} has been changed."
    else
      render "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @delete = delete_firebase(@event.attributes)
    @event.destroy
    redirect_to events_path, notice: "The event #{@event.eventName} has been deleted."
  end

  private

  def event_params
    @event_params ||= params.require(:event).permit(:eventID, :eventName, :event_banner, :eventNoOfPpl, :eventAdminEmail, :eventNoTeams, :gameStatus)
  end

  #TODO - Make it so it's some random strings to form a word? eg: Dinopassword
  def generateEventID
    Random.rand(10000)
  end

  def valid_json?(json)
    JSON.parse(json)
    return true
  rescue JSON::ParserError => e
    return false
  end

  # Firebase Methods
  def init_firebase
    firebase_url = "yourfirebaseio"
    firebase_secret = "yourfirebasesecret"
    # firebase_url = "https://rails-application-2be55.firebaseio.com/"
    # firebase_secret = "MHZ7PouKBG26BuFLJUWBe0Pv9k1PADZ6QEybKpXR"
    Firebase::Client.new(firebase_url, firebase_secret)
  end

  def load_firebase(root_path = "Events")
    firebase_json = init_firebase.get(root_path)
    if valid_json?(firebase_json.raw_body)
      @json_object = JSON.parse(firebase_json.raw_body)
    end
  end

  def update_firebase(event_params, root_path = "Events/")
    init_firebase.update("#{root_path}#{event_params["eventID"]}", event_params)
  end

  def delete_firebase(event_params, root_path = "Events/")
    init_firebase.delete("#{root_path}#{event_params["eventID"]}")
  end

  def save_firebase(event_params, root_path = "Events/")
    init_firebase.set("#{root_path}#{event_params["eventID"]}", event_params)
  end
end
