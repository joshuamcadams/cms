class DemoController < ApplicationController
  
  layout false

  def index
  end

  def hello
  	#render ('index')
  	@array = [1,2,3,4,5]
  	@id = params['id']
  	@page = params[:page]
  end

  def other_hello
  	redirect_to(:controller => 'demo', :action => 'index')
  end

  def text_helpers
  end

  def escape_output

  end

  def make_error
    #render(:text => "test"
    #render(:text => @something.upcase)
    render(:text => "1" + 1)
  end
end
