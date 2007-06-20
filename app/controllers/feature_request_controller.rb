class FeatureRequestController < ApplicationController
  
  before_filter :login_required, :only => [ :add_comment, :add, :update ]
  
  def list
    @show_closed = params[:show_closed] || false
    conditions = @show_closed == '1' || @show_closed == 'true' || @show_closed == true ? ['1 = 1'] : ['state = ?', 'Open']
    @bugs = FeatureRequest.find_all_by_project_id(params[:id], :order => 'id ASC', :conditions => conditions)
    @project = Project.find_by_id(params[:id])
    @project_id = params[:id]
    respond_to do |format|
      format.html
      format.js
      format.xml { render :xml => @bugs.to_xml }
    end
  end
  
  def view
    @bug = FeatureRequest.find_by_id(params[:id])
    @project = @bug.project
    respond_to do |format|
      format.html
      format.xml { render :xml => @bug.to_xml }
    end
  end
  
  def update
    @bug = FeatureRequest.find_by_id(params[:bug][:id])
    @project = @bug.project
    @bug.update_attributes(params[:bug])
    if @bug.valid?
      @bug.save
    end

    render :action => 'view' 
  end
  
  def add_comment
    bug = FeatureRequest.find_by_id(params[:bug_id])
  
    comment = Comment.new
    comment.comment = params[:add_comment]
    comment.user = current_user
    bug.comments << comment
    
    redirect_to :action => 'view', :id => bug.id
  end
  
  def add
    @bug = FeatureRequest.new(params[:bug])
    @bug.created_by = current_user
    @bug.project_id = params[:id] unless params[:id].nil?
  
    unless params[:cancel].nil?
      redirect_to :action => 'list', :id => @bug.project_id
      return
    end
  
    unless params[:bug].nil?
      if @bug.valid?
        @bug.save
        redirect_to :action => 'list', :id => @bug.project_id
        return
      end
    end
  end
  
end