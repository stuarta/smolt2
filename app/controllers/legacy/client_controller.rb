class Legacy::ClientController < ApplicationController
  protect_from_forgery

  def add_json
    # verify session
    validator = Legacy::Token.new
    return head(:bad_request) unless validator.valid?(params[:uuid], params[:token])

    # Find existing pub_uuid of a system
    host = Legacy::Host.find_by_uuid(params[:uuid])
    if host.nil?
      Rails.logger.debug "Failed to find existing host"
      # for testing generate a random pub_uuid
      @pub_uuid = 'pub_' + SecureRandom.uuid
    else
      @pub_uuid = host.pub_uuid
    end

    # Log the original data to BatchQueue.
    # set added=true if immediately processed, else false
    lq = Legacy::BatchQueue.create(hw_uuid: params[:uuid], added: true, data: params[:host])
    # New queue for submissions
    q = Core::Submission.create(hw_uuid: params[:uuid], added: false, data: params[:host])
    ProcessHostJob.perform_later q
  end

  def delete
    Rails.logger.debug "Received request to delete uuid #{params[:uuid]}"
    head :accepted
  end

  def show
    # Could receive either pub_uuid or uuid for a system.
    Rails.logger.debug "Received request for uuid #{params[:uuid]}"
    if params[:uuid].start_with?("pub_")
      @host = Legacy::Host.find_by_pub_uuid(params[:uuid])
    else
      @host = Legacy::Host.find_by_uuid(params[:uuid])
    end
  end

  def pub_uuid
    Rails.logger.debug "Received request for pub_uuid of uuid #{params[:uuid]}"
    # Find host by uuid and return pub_uuid
    host = Legacy::Host.find_by_uuid(params[:uuid])
    if host.nil?
      head (:not_found)
    else
      # Original smolt returns a "tg_flash": null as well
      # but client doesn't need it
      render json: { "pub_uuid": host.pub_uuid }
    end
  end

  def regenerate_pub_uuid
    # generate new pub uuid
    pub_uuid = 'pub_' + SecureRandom.uuid
    Rails.logger.debug "Generated new pub_uuid (#{pub_uuid}) for uuid (#{params[:uuid]})"
    # TODO: Need to save the new pub_uuid.
    # Legacy code updates 1 record in the host table
    render json: { "pub_uuid": pub_uuid }
  end
end
