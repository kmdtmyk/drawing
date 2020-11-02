# frozen_string_literal: true

class RootController < ApplicationController

  def index
    @notices = Notice
      .all
      .order(post_datetime: :desc)
      .limit(5)
  end

end
