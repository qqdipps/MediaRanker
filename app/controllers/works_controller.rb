class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work = Work.find_by(id: params[:id])
    unless work
      head :not_found
    end
  end

  def new
    @work = Work.new()
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      @work.errors.messages.each do |label, message|
        flash.now[label.to_sym] = message
      end
      render :new, status: :bad_request
    end
  end

  def update
  end

  def edit
  end

  private

  # had some trouble here should follow up

  def work_params
    # return params.fetch(:work, {}).permit(:title, :category, :creator, :publication_year, :description)
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end

# title: params[:title],
#                     category: params[:category],
#                     creator: params[:creator],
#                     publication_year: params[:publication_year],
#                     description: params[:description]
