import cv2 as cv
import numpy as np

# opencv chararuco setup
# NB: remember to change the DICT to the correct one if you decide to
# use a different aruco marker!!!
dictionary = cv.aruco.getPredefinedDictionary(cv.aruco.DICT_7X7_100)
numX = 5
numY = 7
size = np.array([numX, numY]) #number of squares in x & y direction
squareLength = 0.05 #in meters
markerLength = 0.04 #meters
board = cv.aruco.CharucoBoard(size, squareLength, markerLength, dictionary)


#calculate image size in pixels. 1mm = 3.77953px
lenX = numX*squareLength*1000*3.77953
lenY = numY*squareLength*1000*3.77953

outSize = np.array([lenX, lenY])
img = cv.aruco.Board.generateImage(lenX, lenY)

