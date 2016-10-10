require_dependency "versions_controller"

module RmCustomization
  module Patches
    module VersionsControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethodsForVersionsController)
        base.class_eval do
          alias_method_chain :index, :rm_customization
          alias_method_chain :create, :rm_customization
          alias_method_chain :update, :rm_customization
          alias_method_chain :edit, :rm_customization
          alias_method_chain :destroy, :rm_customization
        end
      end
    end

    module InstanceMethodsForVersionsController
      def index_with_rm_customization
        project = Project.find_by_identifier(params['project_id'])
        respond_to do |format|
          format.html {
            @versions = index_without_rm_customization
            @versions += VersionLimited.limited(project)
            @versions = @versions.uniq.sort
          }
          format.api {
            @versions = index_without_rm_customization
            @versions += VersionLimited.limited(project)
            @versions = @versions.uniq.sort
          }
        end

      end

      def create_with_rm_customization
        @version = @project.versions.build
        if params[:version_limited]
          attributes = params[:version_limited].dup
          attributes.delete('sharing') unless attributes.nil? || @version.allowed_sharings.include?(attributes['sharing'])
          @version.safe_attributes = attributes
          projects = []
          params[:version_limited][:projects].each do |pid|
            projects << Project.find(pid) unless pid.empty?
          end
          @version.projects = projects
        end

        if request.post?
          if @version.save
            respond_to do |format|
              format.html do
                flash[:notice] = l(:notice_successful_create)
                redirect_back_or_default settings_project_path(@project, :tab => 'versions')
              end
              format.js
              format.api do
                render :action => 'show', :status => :created, :location => version_url(@version)
              end
            end
          else
            respond_to do |format|
              format.html { render :action => 'new' }
              format.js   { render :action => 'new' }
              format.api  { render_validation_errors(@version) }
            end
          end
        end
      end

      def update_with_rm_customization
        @version = VersionLimited.find(@version.id)
        if params[:version_limited]
          attributes = params[:version_limited].dup
          attributes.delete('sharing') unless @version.allowed_sharings.include?(attributes['sharing'])
          @version.safe_attributes = attributes
          projects = []
          params[:version_limited][:projects].each do |pid|
            projects << Project.find(pid) unless pid.empty?
          end
          @version.projects = projects
          if @version.save
            respond_to do |format|
              format.html {
                flash[:notice] = l(:notice_successful_update)
                redirect_back_or_default settings_project_path(@project, :tab => 'versions')
              }
              format.api  { render_api_ok }
            end
          else
            respond_to do |format|
              format.html { render :action => 'edit' }
              format.api  { render_validation_errors(@version) }
            end
          end
        end
      end

      def edit_with_rm_customization
      end

      def destroy_with_rm_customization
        if @version.deletable?
          @version = VersionLimited.find(@version.id)
          if @version.projects.any?
            @version.projects.delete
          end
          @version.destroy
          respond_to do |format|
            format.html { redirect_back_or_default settings_project_path(@project, :tab => 'versions') }
            format.api  { render_api_ok }
          end
        else
          respond_to do |format|
            format.html {
              flash[:error] = l(:notice_unable_delete_version)
              redirect_to settings_project_path(@project, :tab => 'versions')
            }
            format.api  { head :unprocessable_entity }
          end
        end
      end
    end

  end
end
