# BDiffViewController.rb
# blob
#
# Created by Benny Wong on 10/10/09.
# Copyright 2009 Seedless Media. All rights reserved.

class BDiffViewController < NSObject
  attr_accessor :webView
  attr_accessor :previous_button
  attr_accessor :forward_button

  def load_local_html_page(page)
    bundle = NSBundle.mainBundle
    file_path = bundle.pathForResource(page, ofType:'html')

    return if not file_path

    url = NSURL.fileURLWithPath(file_path)
    @webView.mainFrame.loadRequest(NSURLRequest.requestWithURL(url))
  end

  def previous_revision(sender)
  end

  def forward_revision(sender)
  end
end
