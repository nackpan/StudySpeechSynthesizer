//
//  ViewController.m
//  StudySpeechSynthesizer
//
//  Created by nackpan on 2014/05/28.
//  Copyright (c) 2014年 nackpan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIStepper *pitchStepper;
@property (weak, nonatomic) IBOutlet UIStepper *rateStepper;

@property AVSpeechSynthesizer* speechSynthesizer;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Text Field
    NSString* speechText = NSLocalizedString(@"SpeechTextString",nil);
    self.textField.text = speechText;
    self.textField.delegate = self;
    
    // Pitch Stepper
    self.pitchStepper.maximumValue = 2.0;
    self.pitchStepper.minimumValue = 0.5;
    self.pitchStepper.stepValue = 0.1;
    self.pitchStepper.value = 1.0;
    // Pitch Label
    self.pitchLabel.text = [NSString stringWithFormat:@"%1.1f",self.pitchStepper.value];
    // Rate Stepper
    self.rateStepper.maximumValue = AVSpeechUtteranceMaximumSpeechRate;
    self.rateStepper.minimumValue = AVSpeechUtteranceMinimumSpeechRate;
    self.rateStepper.stepValue = 0.1;
    self.rateStepper.value = AVSpeechUtteranceDefaultSpeechRate;
    // Rate Label
    self.rateLabel.text = [NSString stringWithFormat:@"%1.1f",self.rateStepper.value];
    
    
    
    // AVSpeechSynthesizerを初期化する。
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    
}


- (IBAction)pitchValueChanged:(id)sender {
    UIStepper* stepper = (UIStepper*)sender;
    self.pitchLabel.text = [NSString stringWithFormat:@"%1.1f",stepper.value];
    
}

- (IBAction)rateValueChanged:(id)sender {
    UIStepper* stepper = (UIStepper*)sender;
    self.rateLabel.text = [NSString stringWithFormat:@"%1.1f",stepper.value];
}

- (IBAction)speakBtnDidTouch:(id)sender {
    
    // しゃべっているさいちゅうなら、なにもせず戻る
    if(self.speechSynthesizer.speaking )
    {
        return;
    }
    
    
    // utteranceにtext,pitch,rateを設定する
    NSString* speakingText = self.textField.text;
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:speakingText];
    
    float pitch = [self.pitchLabel.text floatValue];
    float rate = [self.rateLabel.text floatValue];
    utterance.pitchMultiplier = pitch;
    utterance.rate = rate;
    
    
    // AVSpeechSynthesizerにAVSpeechUtteranceを設定して読み上げる
    [self.speechSynthesizer speakUtterance:utterance];
}


#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
