class Api::V1::SubmissionsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_submission, only: [:show]

  def index
    @submissions = policy_scope(Submission)
  end


  def show
  end

  def create
    # @assignment, getting passed via post?
    @submission = Submission.new(submission_params)
    @submission.user = current_user
    authorize @submission
    if @submission.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def set_assignment
    @submission = Submission.find(params[:id])
    authorize @submission
  end

  def submission_params
    params.require(@submission).permit(:content, :voice)
  end
end
