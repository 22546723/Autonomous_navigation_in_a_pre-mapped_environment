import cv2 as cv
import numpy as np
#import imutils

# uses opencv aruco namespace to detect the marker info
def detect(img):
    (corners, ids, rejected) = detector.detectMarkers(img)
    return (corners, ids, rejected)

# opencv aruco setup
# NB: remember to change the DICT to the correct one if you decide to
# use a different aruco marker!!!
dictionary = cv.aruco.getPredefinedDictionary(cv.aruco.DICT_7X7_100)
parameters =  cv.aruco.DetectorParameters()
detector = cv.aruco.ArucoDetector(dictionary, parameters)

# reformat the input image array from a memory view to a numpy array
img = np.asarray(img)
#img = imutils.resize(img, width=600)

# converts the image to greyscale. Might need later
# IMPORTANT: note the RGB bit in RGB to gray. It might need to be BGR
gray = cv.cvtColor(img, cv.COLOR_RGB2GRAY)

# get the image info
(corners, ids, rejected) = detect(img)


