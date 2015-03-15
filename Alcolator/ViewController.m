//
//  ViewController.m
//  Alcolator
//
//  Created by Paul Lozada on 2015-03-14.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>



@property (weak,nonatomic) UIButton                 *calculateButton;
@property (weak,nonatomic) UITapGestureRecognizer   *hideKeyboardTapGestureRecognizer;


@end

@implementation ViewController


-(void)loadView{
    
    //Allocate and initialize the all-encompasing view
    self.view = [[UIView alloc]init];
    
    //Allocate and initialize each of our views and the gesture recognizer
    
    UITextField *textField          = [[UITextField alloc]init];
    UISlider *slider                = [[UISlider alloc]init];
    UILabel *label                  = [[UILabel alloc]init];
    UIButton *button                = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap     = [[UITapGestureRecognizer alloc]init];
    
    //Add each view and the gesture recognizer as the view's subviews
    
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    
    //Assign the views and the gesture recognizer to our properties
    
    self.beerPercentTextField               = textField;
    self.beerCountSlider                    = slider;
    self.resultLabel                        = label;
    self.calculateButton                    = button;
    self.hideKeyboardTapGestureRecognizer   = tap;
}


- (void)viewDidLoad {
    
    //Calls the superclass's implementation
    
    [super viewDidLoad];

    //Set our primary view's background to color to lightGrayColor
    
    self.view.backgroundColor = [UIColor colorWithRed:0.31 green:0.311 blue:0.336 alpha:1];
    
    //Tells the text field that `self`, this instance of `ViewController` should be treated as the text field's delegate.
    
    self.beerPercentTextField.delegate = self;
    
    //Set the placeholder text
    
    self.beerPercentTextField.placeholder = NSLocalizedString(@"Alcohol Content Per Beer", "Beer percent placeholder text");
    self.beerPercentTextField.textColor             = [UIColor colorWithRed:0.121 green:0.728 blue:0.838 alpha:1];
    self.beerPercentTextField.backgroundColor       = [UIColor colorWithRed:0.101 green:0.101 blue:0.101 alpha:1];
    self.beerPercentTextField.tintColor             = [UIColor colorWithRed:0.121 green:0.728 blue:0.838 alpha:1];
    self.beerPercentTextField.borderStyle           = UITextBorderStyleRoundedRect;
    
    // Tells `self.beerCountSlider` that when its value changes, it should call `[self -sliderValueDidChange:]`.
    // Equivalent of connecting IBAction in Storyboard.
    
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum amount of beers
    
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;


    // Tells `self.calculateButton` that when a finger is lifted from the buttonwhile still inside its bounds, to call `[self -buttonPressed:]`
    
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    self.calculateButton.tintColor = [UIColor colorWithRed:0.121 green:0.728 blue:0.838 alpha:1];
    
    //Tells the tap gesture recognizer to call `[self -tapGestureDidFire]` when it detects a tap
    
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    //No limit to maximum number of lines on the label
    self.resultLabel.textColor          = [UIColor whiteColor];
    self.resultLabel.font               = [UIFont fontWithName:@"Gill Sans" size:30];
    self.resultLabel.numberOfLines      = 0;
    
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    CGFloat viewWidth       = [[UIScreen mainScreen]bounds].size.width ;
    CGFloat padding         = 20;
    CGFloat itemWidth       = viewWidth - padding - padding;
    CGFloat itemHeight      = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 4);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidChange:(UITextField *)sender {
    
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0 ) {
        sender.text = nil;
    }
}
- (void)sliderValueDidChange:(UISlider *)sender {
    
    NSLog(@"Slider value changed to %f",sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    
}
- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    NSString *beerText;
    
    if(numberOfBeers == 1){
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ wine.",nil),numberOfBeers,beerText,numberOfWineGlassesForEquivalentAlcoholAmount,wineText];
    
    self.resultLabel.text = resultText;
    

}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
