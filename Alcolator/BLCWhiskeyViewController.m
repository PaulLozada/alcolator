//
//  BLCWhiskeyViewController.m
//  Alcolator
//
//  Created by Paul Lozada on 2015-03-14.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCWhiskeyViewController.h"

@interface BLCWhiskeyViewController ()

@end

@implementation BLCWhiskeyViewController

-(void)sliderValueDidChange:(UISlider *)sender{
    
    self.title = [NSString stringWithFormat:@"%0.f Whiskey shot ",self.beerCountSlider.value];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    

    self.title = NSLocalizedString(@"Whiskey", @"whiskey");
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; // assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1; // 1oz shot
    float alcoholPercentageOfWhiskey = 0.4; // 40% is average
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    NSString *beerText;
    
    if(numberOfBeers == 1){
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        whiskeyText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ wine.",nil),numberOfBeers,beerText,numberOfWhiskeyGlassesForEquivalentAlcoholAmount,whiskeyText];
    
    self.resultLabel.text = resultText;
    
    
}


@end
