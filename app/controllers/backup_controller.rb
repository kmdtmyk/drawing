# frozen_string_literal: true

class BackupController < ApplicationController

  def index
    @dump_files = Dir.glob(Rails.root.join('backup', '*.sql'))
      .map { |filepath|
        {
          size: File.size(filepath),
          name: File.basename(filepath),
        }
      }
      .sort_by{ |file| file[:name] }

    @pdf_files = Dir.glob(Rails.root.join('backup', 'system', '*.tar.gz'))
      .map { |filepath|
        {
          size: File.size(filepath),
          name: File.basename(filepath),
        }
      }
      .sort_by{ |file| file[:name] }
  end

  def download
    path = if params[:format] == 'gz'
      Rails.root.join('backup', 'system', "#{params[:filename]}.tar.#{params[:format]}")
    else
      Rails.root.join('backup', "#{params[:filename]}.#{params[:format]}")
    end

    unless File.exists?(path)
      raise ActionController::RoutingError.new('File Not Found')
    end

    send_file path
  end

end
