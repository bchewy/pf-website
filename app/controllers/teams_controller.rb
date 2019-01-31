class TeamsController < ApplicationController
  def new

  end

  def show
    @team = Team.find(params[:id])
  end

  def create
    tp = teams_params
    @team_name = tp[:TeamName]
    @event = Event.find(params[:event_id])
    eID = @event[:eventID]
    @teams = @event.teams.create(tp)
    if @teams.save
      save_firebase(eID, tp, @team_name)
    end
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:event_id])
    @teams = @event.teams.find(params[:id])
    @teams.destroy
    redirect_to event_path(@event)
  end

  private

  def teams_params
    params.require(:team).permit(:TeamName)
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

  # TODO Find out where the teams are sorted, under an entirely new root from firebase? or under Events/eid/Teams...?
  def save_firebase(eid, team_params, root_path = "Events/", team_name)
    #x = "Team " << team_name
    init_firebase.set("#{root_path}#{eid}/Teams/#{team_name}/", teams_params)
  end

end
