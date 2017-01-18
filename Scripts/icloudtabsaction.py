#!/usr/bin/python
# Author: Rich Somerfield
import os
import sys

textbar_text = os.environ['TEXTBAR_TEXT']
if 0 < len(textbar_text):
	starttoken = " <"
	endtoken = ">"

	startIndex = textbar_text.rfind(starttoken)
	endIndex = textbar_text.rfind(endtoken)

	if 0 <= startIndex and startIndex < endIndex:
		url = textbar_text[startIndex+len(starttoken):endIndex]
		print url
		os.system('open %s' % url)