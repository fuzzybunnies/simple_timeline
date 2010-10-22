require 'mongo'

class GridfsController < ApplicationController
  def serve
    gridfs_path = request.env["PATH_INFO"].gsub("/images/","")
    begin
      gridfs_file = Mongo::GridFileSystem.new(Mongoid.database).open(gridfs_path, 'r')
      self.response_body = gridfs_file.read
      self.content_type = gridfs_file.content_type
    rescue
      self.status = 404
      self.content_type = 'text/plain'
      self.response_body = ''
    end
  end

end
