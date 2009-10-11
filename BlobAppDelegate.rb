# BlobAppDelegate.rb
# blob
#
# Created by Benny Wong on 10/10/09.
# Copyright 2009 Seedless Media. All rights reserved.

class BlobAppDelegate < NSObject
  attr_writer :window
  attr_writer :webView
  
  def awakeFromNib
    toolbar = NSToolbar.alloc.initWithIdentifier("BToolbar")
    
    toolbar.setAutosavesConfiguration(true)
    toolbar.setDisplayMode(NSToolbarDisplayModeIconAndLabel)
    toolbar.delegate = BToolbarDelegate.new
    
    @window.setToolbar(toolbar)
    load_local_html_page 'default'
  end
  
  def load_local_html_page(page)
    bundle = NSBundle.mainBundle
    file_path = bundle.pathForResource('default', ofType:'html')
    
    return if not file_path
    
    url = NSURL.fileURLWithPath(file_path)
    @webView.mainFrame.loadRequest(NSURLRequest.requestWithURL(url))
  end
end
