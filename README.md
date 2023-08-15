# Navigation_using_markers
Skripsie project 2023. Aims to allow autonomous marker-to-marker navigation in a pre-mapped environment.

## Updates:
The marker recognition is now working. To test it download the following: <br />
detect_marker.py <br />
marker_recognition.m <br />
test_marker_recognition.m <br />
markers folder <br />
<br />
Then run test_marker_recognition.m

## Installs required to run:
### Python 3.10
Link to downloads: <br />
[Mac](https://www.python.org/downloads/macos/) <br />
[Windows](https://www.python.org/downloads/windows/) <br />

### OpenCV for Python
Run this command to install: <br />
`pip3 install opencv-python` <br />
_Note: This project uses OpenCV version 4.8.0.76_

## Configure Matlab to use correct Python version:
Find the Python3 executable path by running `which python3` in the terminal. <br />
Then run `pe = pyenv('Version','<path_of_python3_executable>')` in Matlab to configure it. <br />
_Note: Matlab 2023a can only use up to Python 3.10. This [link](https://www.mathworks.com/support/requirements/python-compatibility.html) shows compatable Python versions for different Matlab releases._
