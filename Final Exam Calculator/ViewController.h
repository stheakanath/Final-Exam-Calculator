//
//  ViewController.h
//  Final Exam Calculator
//
//  Created by Sony Theakanath on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    UIButton *doneEntering;
    UIButton *doneEnteringPercent;
    UILabel *valueofslider;
    UISlider *slider;
    UIImageView *titleWhenEntering;
    IBOutlet UITextField *gradeGoingIntoFinal;
    IBOutlet UITextField *finalGradeWanted;
    IBOutlet UITextField *percentOfExam;
    IBOutlet UIImageView *fadeviewbackground;
}

-(IBAction) calculate;
-(IBAction) resetdata;
-(IBAction) linktohelp;
@end
