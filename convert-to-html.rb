#!/usr/bin/env ruby

# Simple script that calls the Markdown.pl Daring Fireball script and outputs html from markdown doc.

file_to_convert = ARGV[0]

# check for folders? create if missing

# check for markdown create if missing

# make call to Markdown.pl
system("perl tools/Markdown.pl --html4tags #{file_to_convert} > drafts/#{file_to_convert}.html")
