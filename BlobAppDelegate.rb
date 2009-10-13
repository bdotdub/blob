# BlobAppDelegate.rb
# blob
#
# Created by Benny Wong on 10/10/09.
# Copyright 2009 Seedless Media. All rights reserved.

class BlobAppDelegate < NSObject
  attr_writer :window
  attr_writer :webView

  attr_accessor :webViewController

  def awakeFromNib
    add_main_toolbar

    Git.init
    if Git.found_binary?
      @webViewController.load_local_html_page('default')
    else
      @webViewController.load_local_html_page('git_not_found')
    end
  end
  
  def stub_open_file(sender)
    # Hard coded actions. Will fix when we handle file opening, etc.
    begin
      git_file = Git::File.new("/Users/#{ENV['USER']}/Development/ruby/stage/stage.rb")
      @webViewController.previous_button.setEnabled(true)
      @webViewController.load_local_html_page('container')
      @webViewController.load_file_diffs(git_file)
    rescue Git::FileUntracked
    end
  end

  def add_main_toolbar
    toolbar = NSToolbar.alloc.initWithIdentifier("BToolbar")

    toolbar.setAutosavesConfiguration(true)
    toolbar.setDisplayMode(NSToolbarDisplayModeIconAndLabel)
    toolbar.delegate = BToolbarDelegate.new

    @window.setToolbar(toolbar)
  end
end
