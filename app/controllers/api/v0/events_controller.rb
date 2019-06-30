class Api::V0::EventsController < Api::V0::BaseController

  # need generic api documentation
  def create
    # validate input
    # if valid
    #.  send to kafka; 200
    # else
    #.  send to sentry; send to kafka dead letter topic; 422

  end


end
