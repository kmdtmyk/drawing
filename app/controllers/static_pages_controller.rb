class StaticPagesController < ApplicationController

  def index
    @notices = Notice.all.order(post_datetime: :desc)
  end

end
