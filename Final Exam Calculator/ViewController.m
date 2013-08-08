//
//  ViewController.m
//  Final Exam Calculator
//
//  Created by Sony Theakanath on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(IBAction)calculate
{
    if ([gradeGoingIntoFinal.text length] <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message: @"Your Current Grade Field is Empty!" delegate: self cancelButtonTitle: @"Fix It!" otherButtonTitles: nil];
        [alert show];
    } else if([finalGradeWanted.text length] <= 0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message: @"Your Grade Desired Field is Empty!" delegate: self cancelButtonTitle: @"Fix It!" otherButtonTitles: nil];
        [alert show];
    } else if ([percentOfExam.text length] <= 0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message: @"You haven't set the weight of your final!" delegate: self cancelButtonTitle: @"Fix It!" otherButtonTitles: nil];
        [alert show];
    } else if ([[gradeGoingIntoFinal.text componentsSeparatedByString:@"."] count] > 2){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message: @"You have multiple decimal points in your current grade field!" delegate: self cancelButtonTitle: @"Fix it!" otherButtonTitles: nil];
        [alert show];
        NSLog (@"%i", [[gradeGoingIntoFinal.text componentsSeparatedByString:@"."] count]);
    } else if ([[finalGradeWanted.text componentsSeparatedByString:@"."] count] > 2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message: @"You have multiple decimal points in your desired grade field!" delegate: self cancelButtonTitle: @"Fix it!" otherButtonTitles: nil];
        [alert show];
    } else if ([[percentOfExam.text componentsSeparatedByString:@"."] count] > 2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message: @"You have multiple decimal points in your percent of exam field!" delegate: self cancelButtonTitle: @"Fix it!" otherButtonTitles: nil];
        [alert show];
    } else {
        //Handling calculations if everything is correct.
        float desiredgrade = ([[finalGradeWanted.text substringToIndex:([finalGradeWanted.text length]-1)]  floatValue]);
        float weightofexam = ([[percentOfExam.text substringToIndex:([percentOfExam.text length]-1)] floatValue])/100;
        float currentgrade = ([[gradeGoingIntoFinal.text substringToIndex:([gradeGoingIntoFinal.text length]-1)] floatValue])*((100-(weightofexam*100))/100);
        desiredgrade = desiredgrade-currentgrade;
        float neededpercent = desiredgrade/weightofexam;
        
        if(neededpercent < 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yay!" message: @"You don't need to take the final!" delegate: self cancelButtonTitle: @"Huzzah!" otherButtonTitles: nil];
            [alert show];
        } else if (neededpercent > 100) { 
            NSString *message = [NSString stringWithFormat:@"It's impossible to get your grade but you need to get a %@ percent on your final to get a %@ in the class!", [NSString stringWithFormat:@"%.2f", neededpercent], finalGradeWanted.text];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aw Darn" message: message delegate: self cancelButtonTitle: @"Alright" otherButtonTitles: nil];
            [alert show];
        } else {
            NSString *message = [NSString stringWithFormat:@"You need to get a %@ percent on your final to get a %@ in the class!", [NSString stringWithFormat:@"%.2f", neededpercent], finalGradeWanted.text];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Results" message: message delegate: self cancelButtonTitle: @"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
}

-(IBAction) resetdata
{
    gradeGoingIntoFinal.text = nil;
    percentOfExam.text = nil;
    finalGradeWanted.text = nil;
}

-(IBAction) linktohelp
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sobryapps.com/examcalculator/help.html"]];
}

-(void) fadeIn
{
    [UIImageView beginAnimations:nil context:NULL];
    [UIImageView setAnimationDuration:0.3];
    [fadeviewbackground setAlpha:1];
    [UIImageView commitAnimations];
}

-(void) fadeOut
{
    [UIImageView beginAnimations:nil context:NULL];
    [UIImageView setAnimationDuration:0.3];
    [fadeviewbackground setAlpha:0];
    [UIImageView commitAnimations];
}

-(void)finishedEntering
{
    [gradeGoingIntoFinal resignFirstResponder];
    [finalGradeWanted resignFirstResponder];
    [percentOfExam resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self fadeIn];
    textField.frame = CGRectMake(85, 170, textField.frame.size.width+30, textField.frame.size.height);
    doneEntering.hidden = NO;
    [self.view addSubview:doneEntering];
    titleWhenEntering = [[UIImageView alloc] initWithFrame:CGRectMake(45, 80, 250, 100)];
    [self.view addSubview:titleWhenEntering];
    if (textField == gradeGoingIntoFinal) {
        finalGradeWanted.hidden = YES;
        [titleWhenEntering setImage:[UIImage imageNamed:@"current.png"]];
    } else if (textField == finalGradeWanted) {
        gradeGoingIntoFinal.hidden = YES;
        [titleWhenEntering setImage:[UIImage imageNamed:@"desired.png"]];
    } else if (textField == percentOfExam) {
        gradeGoingIntoFinal.hidden = YES;
        finalGradeWanted.hidden = YES;
        [titleWhenEntering setImage:[UIImage imageNamed:@"weight.png"]];
        
        /*
         //Slider and others
        percentOfExam.hidden = YES;
        doneEnteringPercent.hidden = NO;
        [self.view addSubview:slider];
        [self.view addSubview:valueofslider];
        slider.hidden = NO;
        valueofslider.hidden = NO;
        */
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    doneEntering.hidden = YES;
    titleWhenEntering.hidden = YES;
    NSString *temp = textField.text;
    if([temp length] > 0 && [temp rangeOfString:@"%"].length == 0)
       textField.text = [NSString stringWithFormat:@"%@%@", temp, @"%"]; 
    [self fadeOut]; 
    if (textField == gradeGoingIntoFinal) {
        gradeGoingIntoFinal.frame = CGRectMake(185, 135, 120, 66);
        finalGradeWanted.hidden = NO;
    } else if (textField == finalGradeWanted) {
        finalGradeWanted.frame = CGRectMake(185, 215, 120,66);
        gradeGoingIntoFinal.hidden = NO;
    } else if (textField == percentOfExam){ 
        percentOfExam.frame = CGRectMake(185, 289, 120,66);
        gradeGoingIntoFinal.hidden = NO;
        finalGradeWanted.hidden = NO;
        /*
        percentOfExam.hidden = NO;
        slider.hidden = YES;
        valueofslider.hidden = YES;
        doneEnteringPercent.hidden = YES;
        */
    }
} 


/*
- (void)sliderChanged:(UISlider *)slider {
    [slider setValue:((int)((slider.value + 2.5) / .5) * .5) animated:NO];
    valueofslider.text = [NSString stringWithFormat:@"%.2f%@", slider.value, @"%"];
    percentOfExam.text = [NSString stringWithFormat:@"%.2f", slider.value];
}
 
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[gradeGoingIntoFinal resignFirstResponder];
    [finalGradeWanted resignFirstResponder];
    [percentOfExam resignFirstResponder];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    finalGradeWanted.keyboardType=UIKeyboardTypeDecimalPad;
    finalGradeWanted.background = [UIImage imageNamed:@"box.png"];
    finalGradeWanted.borderStyle = UITextBorderStyleNone;
    finalGradeWanted.font = [UIFont fontWithName:@"MyriadPro-Semibold" size: 30];
    finalGradeWanted.delegate = self;
    
    gradeGoingIntoFinal.background = [UIImage imageNamed:@"box.png"];
    gradeGoingIntoFinal.keyboardType = UIKeyboardTypeDecimalPad;
    gradeGoingIntoFinal.borderStyle = UITextBorderStyleNone;
    gradeGoingIntoFinal.font = [UIFont fontWithName:@"MyriadPro-Semibold" size: 30];
    gradeGoingIntoFinal.delegate = self;
    
    percentOfExam.background = [UIImage imageNamed:@"box.png"];
    percentOfExam.font = [UIFont fontWithName:@"MyriadPro-Semibold" size: 30];
    percentOfExam.keyboardType = UIKeyboardTypeDecimalPad;
    percentOfExam.borderStyle = UITextBorderStyleNone;
    percentOfExam.delegate = self;
    /*
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    percentOfExam.inputView = dummyView;
    percentOfExam.borderStyle = UITextBorderStyleNone;
    percentOfExam.delegate = self;
    */
    
    [fadeviewbackground setAlpha:0];
    
    doneEntering = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [doneEntering addTarget:self action:@selector(finishedEntering) forControlEvents:UIControlEventTouchDown];
    doneEntering.frame = CGRectMake(240, 180, 44, 44);
    [self.view addSubview:doneEntering];
    doneEntering.hidden = YES;

    /*
    //Entering weight
    
    //The button for doneenteringpercent
    doneEnteringPercent = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [doneEnteringPercent addTarget:self action:@selector(finishedEntering) forControlEvents:UIControlEventTouchDown];
    doneEnteringPercent.frame = CGRectMake(200, 155, 44, 44);
    [self.view addSubview:doneEnteringPercent];
    doneEnteringPercent.hidden = YES;
    
    
    CGRect frame = CGRectMake(60, 130, 200.0, 10.0);
    slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 0.0;
    slider.maximumValue = 100.0;
    slider.continuous = YES;
    slider.value = 50.0;
    
    valueofslider = [[UILabel alloc] initWithFrame:CGRectMake(60, 130, 200, 100)];
    valueofslider.backgroundColor = [UIColor clearColor];
    valueofslider.font = [UIFont fontWithName:@"MyriadPro-Semibold" size: 30];
    valueofslider.text = @"50.00%";
    valueofslider.textColor = [UIColor whiteColor];
    */
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
