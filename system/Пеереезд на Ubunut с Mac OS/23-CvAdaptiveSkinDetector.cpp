//
// ������ ������������� CvAdaptiveSkinDetector
//
// robocraft.ru
//

#include <cv.h>
#include <highgui.h>
#include <cvaux.h> // ��� CvAdaptiveSkinDetector

#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
	IplImage* image=0, *dst=0, *mask=0;

	// ��� �������� ������� ������ ����������
	const char* filename = argc >= 2 ? argv[1] : "Image0.jpg";
	// �������� ��������
	image = cvLoadImage(filename, 1);

	printf("[i] image: %s\n", filename);
	assert( image != 0 );

	// ������� �����������
	cvNamedWindow( "original");
	cvShowImage( "original", image );

	// �������� ��� �������� �����������
	dst = cvCloneImage(image);

	// �������� ����
	CvAdaptiveSkinDetector filter(1, CvAdaptiveSkinDetector::MORPHING_METHOD_ERODE); // MORPHING_METHOD_ERODE_DILATE

	// �������� ��� �������� ���������� (�����)
	mask = cvCreateImage( cvGetSize(image), IPL_DEPTH_8U, 1);

	// ���������
	filter.process(image, mask);

	// ������� �����
	cvNamedWindow( "mask");
	cvShowImage( "mask", mask);

	// ����������� �� ���� �������� �����������
	// � ����������� � �������� ��������, ��� ����������� �����
	// ������ ���������� �� ���������
	for( int y=0; y<dst->height; y++ ) {
		uchar* ptr = (uchar*) (dst->imageData + y * dst->widthStep); // �����������
		uchar* ptrM = (uchar*) (mask->imageData + y * mask->widthStep); // �����
		for( int x=0; x<dst->width; x++ ) {
			if(ptrM[x]){ // ����� �����������
				// 3 ������ 
				//ptr[3*x] = ; // B
				ptr[3*x+1] = 255; // G
				//ptr[3*x+2] = ; // R
			}
		}
	}

	// �������  ��������
	cvNamedWindow( "dst");
	cvShowImage( "dst", dst );

	// ��� ������� �������
	cvWaitKey(0);

	// ����������� �������
	cvReleaseImage(& image);
	cvReleaseImage(&dst);
	cvReleaseImage(&mask);

	// ������� ����
	cvDestroyAllWindows();
	return 0;
}
