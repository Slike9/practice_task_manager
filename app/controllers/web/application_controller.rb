require "application_responder"

class Web::ApplicationController < ::ApplicationController
  self.responder = ApplicationResponder
  respond_to :html

  add_breadcrumb :home, :root_path
end
