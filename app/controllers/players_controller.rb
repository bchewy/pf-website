class PlayersController < ApplicationController
  def index
    #load_firebase
    @players = Player.all
  end

  def new
  end

  def create
    pp = player_params
    pp[:score] = 0 #Initalise player score with 0
    @team = Team.find(params[:team_id])
    #@event = Event.find(params[:team_id])
    #@eID = @event[:eventID]

    @team_name = @team[:name]
    #@eID = @event[:eventID]
    @player = @team.players.create(pp)
    redirect_to players_path
  end

  def destroy
    #@team = Team.find(params[:team_id])
    #@player = @teams.players.find(params[:id])
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to players_path
  end

  def start_sort
    add_players_to_list(get_players, @team_name, @eID)
    redirect_to players_path
  end

  private

  def player_params
    params.require(:player).permit(:AndroidID, :name, :score)
  end

  # Method to assign players
  # Psuedocode is written below
  # 1. Pull the androidids (already done from load_firebase method)
  # (/Players/1:randomandroidid) or (/Players/samerandomandroidid:randomandroidid)
  # (/Players/2:randomandroidid) or (/Players/samerandomandroidid:randomandroidid)
  # (/Players/3:randomandroidid) or (/Players/samerandomandroidid:randomandroidid)
  # 2. Navigate to Teams/TeamName/Members/
  # 3. Save the pulled android ids to there.
  def get_players
    load_firebase
    # @player_list = Hash.new
    @player_list = Array.new
    @json_object.each do |key, value|
      @player_list << value
    end
    @player_list
  end

  # TODO The parameters for this function may change depending on where it is saved in firebase ie: team_name and eID (eid is not needed if not stored under events/edi)
  def add_players_to_list(player_list, team_name, eID) #Takes a player list to sort
    # player_list.each_with_index do |item, index| #item is androidID, since 1 androidid is a player
    #   if index == 0
    #     index+1
    #   end
    #   if index == 1
    #     add_players_to_fb(android_id=item)
    #   end
    #   if index == 2
    #     add_players_to_fb(android_id=item)
    #   end
    #   if index == 3
    #     add_players_to_fb(android_id=item)
    #   end
    #   if index == 4
    #     add_players_to_fb(android_id=item)
    #   end
    #
    # end
    # TODO Check if sorting can be done with multiple teams
    player_list.each_with_index do |item, index|
      if index == 0
        add_players_to_fb(item, item, team_name, eID)
      end
      if index == 1
        add_players_to_fb(item, item, team_name, eID)
      end
      if index == 2
        add_players_to_fb(item, item, team_name, eID)
      end
      if index == 3
        add_players_to_fb(item, item, team_name, eID)
      end
    end
  end

  ## Adding players to firebase is here
  def add_players_to_fb(root_path = "Events/", android_id, team_name, eid)
    init_firebase.set("#{root_path}#{eid}/#{team_name}/#{android_id}/", android_id)
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
    Firebase::Client.new(firebase_url, firebase_secret)
  end

  def load_firebase(root_path = "Events/6528/Players")
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

  def save_firebase(eid, picture_params, root_path = "Events/")
    init_firebase.set("#{root_path}#{eid}/pictures/gamephase1/", picture_params)
  end


end
