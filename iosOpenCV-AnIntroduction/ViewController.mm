//
//  ViewController.m
//  iosOpenCV-AnIntroduction
//
//  Created by Sri Raghu Malireddi on 23/07/16.
//  Copyright © 2016 Sri Raghu Malireddi. All rights reserved.
//

#import "ViewController.h"

// To include C++ code and OpenCV, add the following lines
#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import "opencv2/highgui/ios.h"
#endif

#include <iostream>
using namespace std;
using namespace cv;

@interface ViewController () {
    // Setup the view
    UIImageView *imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Setup the imageView to take the entire app screen
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0,
                                                              self.view.frame.size.width,
                                                              self.view.frame.size.height)];
    // Correct the aspect ratio of the content in imageView
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //Add imageView as a sub view
    [self.view addSubview:imageView];
    
    // Read the image and display if it is loaded properly,
    // else, show the error message
    UIImage *image = [UIImage imageNamed:@"lena.png"];
    if(image != nil) imageView.image = image;
    else cout << "Cannot read in the file" << endl;
    
    // Convert the image from UIImage to Mat
    Mat imageCV; UIImageToMat(image, imageCV);
    
    // OpenCV operations:
    // Convert the image from RGB to GrayScale
    Mat gray; cvtColor(imageCV, gray, CV_RGBA2GRAY);
    // Apply the gaussian blur to the above image
    Mat gaussianBlur; GaussianBlur(gray, gaussianBlur, cv::Size(5,5), 2, 2);
    // Apply the Canny edge detection
    Mat edges; Canny(gaussianBlur, edges, 0, 50);
    
    // Display the result
    imageView.image = MatToUIImage(edges);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
