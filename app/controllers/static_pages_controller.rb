class StaticPagesController < ApplicationController

  def index
    @notices = Notice
      .all
      .order(post_datetime: :desc)
      .limit(5)
  end

end
