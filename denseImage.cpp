#include <opencv2/video/tracking.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/gpu/gpu.hpp>

#include <stdio.h>
#include <iostream>
using namespace cv;

int main(int argc, char** argv){
	// IO operation
	const char* keys =
		{
			"{ f  | vidFile      | ex2.avi | filename of video }"
			"{ i  | imgFile      | flow_i | filename of flow image}"
		};

	CommandLineParser cmd(argc, argv, keys);
	string vidFile = cmd.get<string>("vidFile");
	string imgFile = cmd.get<string>("imgFile");

	VideoCapture capture(vidFile);
	if(!capture.isOpened()) {
		printf("Could not initialize capturing..\n");
		return -1;
	}

	int frame_num = 1;
        Mat frame;

	while(true) {
		capture >> frame;
		if(frame.empty())
			break;
		char tmp[20];
		sprintf(tmp,"_%05d.jpg",int(frame_num));
   
		imwrite(imgFile + tmp, frame);

		frame_num = frame_num + 1;
	}
	return 0;
}
