class PicturesController < ApplicationController
  def new
  end

  def create
    pp = picture_params
    @event = Event.find(params[:event_id])
    eid = @event[:eventID]
    @pictures = @event.pictures.create(pp)
    if @pictures.save
      save_firebase(eid, pp)
      redirect_to event_path(@event)
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @pictures = @event.pictures.find(params[:id])
    @pictures.destroy
    redirect_to event_path(@event)
  end

  private

  def picture_params
    params.require(:picture).permit(:answers, :hints, {event_pics: []})
  end

  # Firebase Methods
  def init_firebase
    firebase_url = "yourfirebaseio"
    firebase_secret = "yourfirebasesecret"
    Firebase::Client.new(firebase_url, firebase_secret)
  end

  def load_firebase(root_path = "Events")
    firebase_json = init_firebase.get(root_path)
    if valid_json?(firebase_json.raw_body)
      @json_object = JSON.parse(firebase_json.raw_body)
    end
  end

  def update_firebase(picture_params, root_path = "Events/")
    init_firebase.update("#{root_path}#{picture_params["eventID"]}", picture_params)
  end

  def delete_firebase(picture_params, root_path = "Events/")
    init_firebase.delete("#{root_path}#{picture_params["eventID"]}")
  end

  # TODO Pictures are currently hardcoded to gamephase 1
  def save_firebase(eid, picture_params, root_path = "Events/")
    init_firebase.set("#{root_path}#{eid}/pictures/gamephase1/", picture_params)
  end
end
