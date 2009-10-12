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
    create_webview_controller
    
    Git.init
    if Git.found_binary?
      @webViewController.load_local_html_page('default')
    else
      @webViewController.load_local_html_page('git_not_found')
    end
  end
  
  def add_main_toolbar
    toolbar = NSToolbar.alloc.initWithIdentifier("BToolbar")
    
    toolbar.setAutosavesConfiguration(true)
    toolbar.setDisplayMode(NSToolbarDisplayModeIconAndLabel)
    toolbar.delegate = BToolbarDelegate.new
    
    @window.setToolbar(toolbar)
  end
  
  def create_webview_controller
    self.webViewController = BDiffViewController.new
    self.webViewController.webView = @webView
  end
end
