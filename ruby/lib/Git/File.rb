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

    def remove_diff_header(lines)
      index_of_last_diff_line = -1
      lines.each_with_index do |line, index|
        if line =~ /^@@/
          index_of_last_diff_line = index
          break
        end
      end


      raise "Could not find last line of diff" if index_of_last_diff_line == -1
      (index_of_last_diff_line + 1).times do lines.shift end
    end

    def revision_diff(first_revision, second_revision)
      first_revision = current_revision    if first_revision.nil?
      second_revision = previous_revision  if second_revision.nil?

      if second_revision
        file_diff = `#{Git.path} diff -U10000 #{first_revision}..#{second_revision} -- #{path}`
        file_lines = file_diff.split("\n")
        remove_diff_header file_lines
      else
        file_lines = `cat #{path}`.chomp.split("\n")
      end

      file_lines
    end
  end
end
