module Portfolio
  class ArtworkCollaboratorsController < Portfolio::BaseController

    before_action :set_collaboration, only: [:accept, :reject]

    def accept
      if @collaboration.accept!
        redirect_to root_path, notice: "You have accepted to be a collaborator for #{@artwork.title}"
      else
        redirect_to root_path, alert: 'Something went wrong. Please try again.'
      end
    end

    def reject
      if @collaboration.reject!
        redirect_to root_path, notice: "You have rejected to be a collaborator for #{@artwork.title}"
      else
        redirect_to root_path, alert: 'Something went wrong. Please try again'
      end
    end

    private

    def set_collaboration
      @collaboration = current_user.artwork_collaborators.find(params[:id])
      @artwork = @collaboration.artwork
    end
  end
end
