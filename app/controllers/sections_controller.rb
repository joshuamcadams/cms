class SectionsController < ApplicationController


  layout "admin"

  before_action :confirm_logged_in
  before_action :find_page
  before_action :find_subject
  
  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section destroyed successfully."
    redirect_to(:action => 'index', :page_id => @page.id)
  end

  def edit
    @section = Section.find(params[:id])
    @section_count = Section.count
    @pages = @page.subject.pages.order("position ASC")
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully."
      redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
    else
      @section_count = Section.count
      @pages = Page.order("position ASC")
      render('edit')
    end
  end
  
  def index
    @sections = @page.sections.order("position ASC")
  end

  def new
    @section = Section.new({:name => "Default"})
    @section_count = Section.count + 1
    @pages = @page.subject.pages.order("position ASC")
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created successfully."
      redirect_to(:action => 'index', :page_id => @page.id)
    else
      @section_count = Section.count + 1
      @pages = Page.order("position ASC")
      render('new')
    end
  end

  def show
    @section = Section.find(params[:id])
  end


  private

    def section_params
      params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end

    def find_page
      if params[:page_id]
        @page = Page.find(params[:page_id])
      end
    end

    def find_subject
        @subject = @page.subject
    end



end
