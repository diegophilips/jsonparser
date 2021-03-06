class JobsController < ApplicationController
  def new
    @job = Job.new
  end

  def create
    jobs = json_upload
    jobs.each do |job|
      new_job_params = {
        title: job['Title'],
        job_number: job['JobNumber'],
        description: job['Description'],
        company_name: job['CompanyName'],
        url: job['Url'],
        location: job['Location'],
        salary: job['Salary'],
        closing_date: job['ClosingDate'],
        required_attributes: job['RequiredAttributes'],
        responsabilities: job['Responsilibities'],
        benefits: job['Benefits'],
        apply: job['Apply']
      }
      @job = Job.create(new_job_params)
    end
    if @job.save
      redirect_to new_job_path
      flash[:notice] = 'Your file was successfully imported'
    else
      flash.now[:notice] = 'There was a problem with your file'
      render :new
    end
  end

  def index
    if params[:query].present?
      sql_query = 'location ILIKE :query OR company_name ILIKE :query
                     OR title ILIKE :query OR description ILIKE :query OR required_attributes
                     ILIKE :query OR responsabilities ILIKE :query OR
                     benefits ILIKE :query'
      @jobs = Job.where(sql_query, query: "%#{params[:query]}%").paginate(page: params[:page], per_page: 10)
    else
      @jobs = Job.paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  private

  def json_upload
    filepath = params[:job][:attached_files][:file]
    serialized_jobs = File.read(filepath)
    jobs = JSON.parse(serialized_jobs)
  end
end
