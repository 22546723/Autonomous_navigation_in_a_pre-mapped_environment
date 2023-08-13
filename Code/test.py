import cv2 as cv
import numpy as np

def detect(img):
    # gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)
    (corners, ids, rejected) = detector.detectMarkers(img)
    return (corners, ids, rejected)

dictionary = cv.aruco.getPredefinedDictionary(cv.aruco.DICT_7X7_100)
parameters =  cv.aruco.DetectorParameters()
detector = cv.aruco.ArucoDetector(dictionary, parameters)

img = np.asarray(img)
gray = cv.cvtColor(img, cv.COLOR_RGB2GRAY)
(corners, ids, rejected) = detect(img)
print(ids)
print(img.shape)

disp = img

