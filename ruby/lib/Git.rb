# Git.rb
# blob
#
# Created by Benny Wong on 10/12/09.
# Copyright 2009 Seedless Media. All rights reserved.

class Git
  # List partially stolen from GitX
  DEFAULT_LOCATIONS = %w[
    /usr/bin/git
    /opt/bin/git
    /usr/local/bin/git
    /opt/local/bin/git
    /sw/bin/git
    /opt/git/bin/git
    /usr/local/bin/git
    /usr/local/git/bin/git
  ]

  @@git_path = nil

  def Git.init
    @@git_path = Git.find_binary
  end

  def Git.find_binary
    git_path = `which git`.chomp
    return git_path unless git_path.empty?

    locations = DEFAULT_LOCATIONS.clone
    locations << "~/bin/git".stringByExpandingTildeInPath

    locations.each do |path|
      return path if ::File.exists?(path) and ::File.executable?(path)
    end

    return nil
  end

  def Git.found_binary?
    !@@git_path.nil?
  end

  def Git.path
    @@git_path
  end
end
