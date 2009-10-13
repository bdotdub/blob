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
    load_file_diffs(@git_file)
  end

  def forward_revision(sender)
  end

  def load_file_diffs(git_file, first_revision=nil, second_revision=nil)
  @git_file = git_file
    first_revision = git_file.current_revision    if first_revision.nil?
    second_revision = git_file.previous_revision  if second_revision.nil?

    file_diff = `#{Git.path} diff -U10000 #{first_revision}..#{second_revision} -- #{git_file.path}`
    file_lines = file_diff.split("\n")
    remove_diff_header file_lines

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

  def replace_container_text(html)
    script_object = @webView.windowScriptObject()
    args = [html]
    script_object.callWebScriptMethod("replaceContainerWithHTML", withArguments:args)
  end
end
