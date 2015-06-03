//
//  ViewController.m
//  FalseSenseOfSecurity
//
//  Created by Oliver Ng on 30/5/15.
//  Copyright (c) 2015 Security Compass. All rights reserved.
//  http://www.securitycompass.com
//

#import "ViewController.h"
#import <sys/ptrace.h>
#import "DebugValidate.h"     // import our Debugger Checking Static code provided by Apple Docs

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
 
  
  // call our two debug detection routines
  [self ptraceTest];
  [self debuggerDetect];
}

- (void)ptraceTest {
  
  // check if app being debugged using the C macro
#ifndef DEBUG
  // if so, deny ptrace from attaching (will exit segfault gdb)
  ptrace(PT_DENY_ATTACH, 0, 0, 0);
#endif

  // if we pass our test, update the label
  self.debugTxtLabel.text = @"I passed ptrace test";
  
}

- (void)debuggerDetect{
  
  // check if app being debugged using the C macro
#ifndef DEBUG
  // this code uses Apple's debugger detection
  bool debugDetect = AmIBeingDebugged();
  
  // if debugger detected, update the label and return from function
  if (debugDetect){
    NSLog(@"Debugger detected, exit method.");
    self.debugTest2TxtLabel.text = @"I am being debugged, Argh!";
    return;
  }
#endif
  
  // passed debugger test, update the label - wont get here if above returned
  self.debugTest2TxtLabel.text = @"I passed debugger detection";
  
}




- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
