# frozen_string_literal: true

class BackupController < ApplicationController

  def index
    @files = Dir.glob(Rails.root.join('backup', '*.sql'))
      .map { |filepath|
        {
          size: File.size(filepath),
          name: File.basename(filepath),
        }
      }
      .sort_by{ |file| file[:name] }
  end

  def download
    path = Rails.root.join('backup', "#{params[:filename]}.#{params[:format]}")
    unless File.exists?(path)
      raise ActionController::RoutingError.new('File Not Found')
    end
    send_file path
  end

end
