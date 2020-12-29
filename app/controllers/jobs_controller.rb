class JobsController < ApplicationController

  def new
    @job = Job.new
  end

  def create
    raise
    json_upload
    @job = Job.new(jobs_param)
    if @job.save
      flash.now[:notice] = 'Your file was successfully imported'
    else
      render :new
    end
  end

  def index
    @jobs = Job.all
  end

  private

  def json_upload
    #filepath = simple_form_for
    serialized_jobs = File.read
    jobs = JSON.parse(serialized_jobs)
  end

  def jobs_param
    params.permit(:file)
  end
end
