# File.rb
# blob
#
# Created by Benny Wong on 10/12/09.
# Copyright 2009 Seedless Media. All rights reserved.

class Git
  class File
    attr_accessor :revisions
    attr_accessor :path

    def initialize(filename)
      Dir.chdir(::File.expand_path(::File.dirname(filename)))
      @revisions = `#{Git.path} rev-list HEAD -- #{filename}`.chomp.split("\n")

      raise Git::FileUntracked if $? != 0
      @path = filename
      @current_revision_index = 0
    end

    def current_revision
      @revisions[@current_revision_index]
    end

    def previous_revision
      revision_hash = nil
      if @current_revision_index <= (@revisions.length - 2)
        revision_hash = @revisions[@current_revision_index + 1]
      end

      revision_hash
    end
  end
end
