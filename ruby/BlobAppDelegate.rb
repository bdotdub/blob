# BlobAppDelegate.rb
# blob
#
# Created by Benny Wong on 10/10/09.
# Copyright 2009 Seedless Media. All rights reserved.

class BlobAppDelegate < NSObject
  attr_writer :window
  attr_writer :webView

  attr_accessor :webViewController
  attr_accessor :git_file

  def awakeFromNib
    add_main_toolbar

    Git.init
    if Git.found_binary?
      @webViewController.load_local_html_page('default')
    else
      @webViewController.load_local_html_page('git_not_found')
    end
  end

  def open_file(filename)
    # Hard coded actions. Will fix when we handle file opening, etc.
    begin
      @git_file = Git::File.new(filename)
      @webViewController.load_local_html_page('container')
      @webView.setFrameLoadDelegate(self)

      if @git_file.revisions.length > 1
        @webViewController.previous_button.enabled = true
      end
    rescue Git::FileUntracked
      @git_file = nil
    end
  end

  def webView(sender, didFinishLoadForFrame:frame)
    @webViewController.load_file_diffs(@git_file)
  end

  def open_file_panel(sender)
    open_panel = NSOpenPanel.openPanel
    open_panel.allowsMultipleSelection = false

    result = open_panel.runModalForTypes(nil)
    if result == NSOKButton
      filename = open_panel.filenames[0]
      open_file(filename)
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
