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

  def load_file_diffs(git_file, first_revision=nil, second_revision=nil)
    file_lines = git_file.revision_diff(first_revision, second_revision)

    diff_output = '<pre>'
    file_lines.each do |line|
      line_output = ''
      if line =~ /^\+/
        line_output << "<div class='add'>"
      elsif line =~ /^-/
        line_output << "<div class='delete'>"
      else
        line_output << "<div>"
      end

      line_output << line
      line_output << "</div>"

      diff_output << line_output
    end
    diff_output << '</pre>'
    replace_container_text diff_output
  end

  def replace_container_text(html)
    script_object = @webView.windowScriptObject()
    args = [html]
    script_object.callWebScriptMethod("replaceContainerWithHTML", withArguments:args)
  end
end
