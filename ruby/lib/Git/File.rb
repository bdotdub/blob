# File.rb
# blob
#
# Created by Benny Wong on 10/12/09.
# Copyright 2009 Seedless Media. All rights reserved.

class Git
  class File
    attr_accessor :revisions

    def initialize(filename)
      Dir.chdir(::File.expand_path(::File.dirname(filename)))
      revisions = `#{Git.path} rev-list HEAD -- #{filename}`.chomp.split("\n")

      raise Git::FileUntracked if $? != 0
    end
  end
end
