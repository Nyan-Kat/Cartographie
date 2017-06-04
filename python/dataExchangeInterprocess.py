#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  dataExchangeInterprocess.py
#  
#  Copyright 2017  <pi@raspberrypi>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

import os
import time
from time import gmtime, strftime
from subprocess import call
from threading import Thread

#creation thread principal
class CThread(Thread):
	def __init__(self,path):
		super().__init__()
		self.__path=path
		
	def run(self):
		call([self.__path])
		

class PyThread(Thread):
	def __init__(self,tubeNommepath):
		super().__init__()
		self.tubeNommepath=tubeNommepath
		self.end=False
		self.count=0
		self.mesure_directory="../mesure/"
		self.f=self.mesure_directory+"mesure.txt"
		with open(self.f,"w"):
			pass
	def run(self):
		try:
			os.mkfifo(self.tubeNommepath)
			
		except:
			os.unlink(self.tubeNommepath)
			os.mkfifo(self.tubeNommepath)
		l2=[]
		while(not self.end):
			try:
				with open(self.tubeNommepath, 'r') as tubeNomme:

					with open(self.f,"r+") as f:
						
						f.seek(0,2)
						l=list(map(int,tubeNomme.readline().split())) 
						if l==[]:
							l=[0 for i in range(0,180)]
						l1=strftime('%Y-%m-%d %H:%M:%S', gmtime())
						l1+=", "
						f.write(l1)
						print(l)
						l2=[(l[i],i-90) for i in range(30,151,5)]
						f.write(str(l2)+"\n")
			
					print(l2)
			except ValueError:
				print(ValueError)
		os.unlink(self.tubeNommepath)


def main():
	
	init=True
	vision=CThread("./vision")
	py=PyThread("/tmp/visionData.fifo")
	vision.start()
	time.sleep(1)
	py.start()
	

		#~ if init:
			#~ 
			#~ init=False
	vision.join()

	py.end=True
	f=open("/tmp/visionData.fifo","w")
	f.close()
	py.join()
if __name__ == '__main__':
	main()

