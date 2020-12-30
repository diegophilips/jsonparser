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
   Job.create(new_job_params)
              end
    #if @jobs.save
      redirect_to new_job_path
      flash[:notice] = 'Your file was successfully imported'

    #else
     # render :new
    #end
  end

  def index
    @jobs = Job.all
  end

  private

  def json_upload
    filepath = params[:job][:attached_files][:file]
    serialized_jobs = File.read(filepath)
    jobs = JSON.parse(serialized_jobs)
  end

    #def new_job_params
    #params.require(:jobs).permit(:job_number, :title, :description, :company_name, :url, :location, :salary, :closing_date, :required_attributes, :responsabilities, :benefits, :apply)
    #end
end
