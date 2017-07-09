#! /usr/bin/python
'''
File Name: image2coe.py
Author: Jesse Millwood
Python Version: 2.7
Date: March 12 2014


Description:
	This script loads in an image defined by the user and converts it to a
	Xilinx Coefficients File (.coe)
	The majority of this code is just adapted from a MATLAB script, "IMG2coe8.m",
	that was found in an on-line example at: 
	http://www.lbebooks.com/downloads.htm#vhdlnexys
	The specific example is at:
	http://www.lbebooks.com/downloads/exportal/VHDL_NEXYS_Example24.pdf

TO USE:
	The easiest way to use this script is to copy this module to the directory
	that contains the image that you want to convert. Then  start and instance 
	or your terminal emulator or command prompt in that same directory. Run this 
	module with the python command from the terminal emulator or command prompt
	text editor and change the contents of the string named ImageName. 
	Then run the script from a command line.
'''
# Imported Standard Modules
import sys
from PIL import Image 




def Convert (ImageName):
	"""
		This converts the given image into a Xilinx Coefficients (.coe) file.
		Pass it the name of the image including the file suffix.
		The file must reside in the directory from which this function is called
		or provide the absolute path. 
	"""
	# Open image
	img 	= Image.open(ImageName)
	# Verify that the image is in the 'RGB' mode, every pixel is described by 
	# three bytes
	if img.mode != 'RGB':
		img = img.convert('RGB')

	# Store Width and height of image
	width 	= img.size[0]
	height	= img.size[1]

	# Create a .coe file and open it.
	# Write the header to the file, where lines that start with ';' 
	# are commented
	filetype = ImageName[ImageName.find('.'):]
	filename = ImageName.replace(filetype,'.coe')
	imgcoe	= open(filename,'wb')
	imgcoe.write(';	VGA Memory Map\n')
	imgcoe.write('; .COE file with hex coefficients\n')
	imgcoe.write('; Height: {0}, Width: {1}\n'.format(height,width))
	imgcoe.write('memory_initialization_radix = 2;\n')
	imgcoe.write('memory_initialization_vector =\n')
	
	# Iterate through every pixel, retain the 3 least significant bits for the
	# red and green bytes and the 2 least significant bits for the blue byte. 
	# These are then combined into one byte and their hex equivalent is written
	# to the .coe file
	cnt = 0
	line_cnt = 0
	for r in range(0, height):
		for c in range(0, width):
			cnt += 1
			# Check for IndexError, usually occurs if the script is trying to 
			# access an element that does not exist
			try:
				R,G,B = img.getpixel((c,r))
			except IndexError:
				print 'Index Error Occurred At:'
				print 'c: {}, r:{}'.format(c,r)
				sys.exit()

                        Intensity = 0.3*R + 0.59*G + 0.11*B
                        Outbit = "1" if Intensity < 128 else "0"
                        
			# Check for Value Error, happened when the case of the pixel being 
			# zero was not handled properly	
			try:
                                imgcoe.write(Outbit)
			except ValueError:
				print 'Value Error Occurred At:'
				print 'R:{0} G:{1} B{2}'.format(R,G,B)
				sys.exit()
			# Write correct punctuation depending on line end, byte end,
			# or file end
			if c==width-1 and r==height-1:
				imgcoe.write(';')
			else:
				if cnt%32 == 0:
					imgcoe.write(',\n')
					line_cnt+=1
				else:
					imgcoe.write(',')
                                        
	imgcoe.close()
	print 'Xilinx Coefficients File:{} DONE'.format(filename)
	print 'Converted from {} to .coe'.format(filetype)
	print 'Size: h:{} pixels w:{} pixels'.format(height,width)


if __name__ == '__main__':
	ImageName = raw_input('Enter the name of your image: ')
	Convert(ImageName)
