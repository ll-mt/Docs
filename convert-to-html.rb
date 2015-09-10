#!/usr/bin/env ruby

# Simple script that calls the Markdown.pl Daring Fireball script and outputs html from markdown doc.

# At the moment there is no checking for spaces in file_to_convert.
# User will need to rap the arg in quotes
file_to_convert = ARGV[0]

# check for folders? create if missing
`mkdir tools` unless File.directory?('tools')
`mkdir drafts` unless File.directory?('drafts')

# check for markdown create if missing
unless File.exists?('tools/Markdown.pl')
  `wget 'http://daringfireball.net/projects/downloads/Markdown_1.0.1.zip'`
  `unzip Markdown_1.0.1.zip`
  `cp Markdown_1.0.1/Markdown.pl tools/Markdown.pl`
  `rm -rf Markdown_1.0.1*`
end
  

# make call to Markdown.pl
system("perl tools/Markdown.pl --html4tags #{file_to_convert} > drafts/#{file_to_convert}.html")
