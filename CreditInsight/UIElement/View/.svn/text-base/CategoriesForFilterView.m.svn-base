//
//  CategoriesForFilterView.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/7/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "CategoriesForFilterView.h"
#import "Category.h"

@interface CategoriesForFilterView()

@property (nonatomic) int head;  //index of current category in array.
@property (nonatomic) NSMutableArray *labelRadians;
@property (strong, nonatomic) NSMutableArray *categoryNames; //category strings
@property (strong, nonatomic) NSMutableArray *viewableLabels; // 5 viewable labels in circle, like a half of clock

@end

#define MIN_CATEGORY_SIZE 10
#define CATEGORY_PLACEHOLDER @""
#define RADIUS 82
#define CIRCLE_CENTER_X 0
#define CIRCLE_CENTER_Y 204
#define ZERO_RADIUS 0.00

@implementation CategoriesForFilterView

CGFloat lastRotate = 0.0;
CGFloat radianStep = M_PI / 5;
CGFloat initRadian = 0;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CategoriesForFilterView" owner:self options:nil];
    if (nibs) {
      self = [nibs objectAtIndex:0];
      self.frame = frame;
    }
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  [self initCategories];
  [self initLabels];
}

- (void)initCategories {
  _categoryNames = [NSMutableArray array];
  
  for (Category *category in _categories) {
    [_categoryNames addObject:category.categoryName];    
  }
  
  // If categories' size is less than 10, expand to 10
  int cnt = [self.categoryNames count];
  if (cnt < MIN_CATEGORY_SIZE) {
    for (int i = 0; i < MIN_CATEGORY_SIZE - cnt; i++) {
      [self.categoryNames addObject:CATEGORY_PLACEHOLDER];
    }
  }
  self.head = 0;
}

-(void)updateLabel:(UILabel *)label radian:(CGFloat)radian
{
  CGPoint center = CGPointMake(CIRCLE_CENTER_X + RADIUS * cos(radian), CIRCLE_CENTER_Y + RADIUS * sin(radian));  
  label.layer.bounds = CGRectMake(0, 0, 90, 80);
  label.layer.anchorPoint = CGPointMake(0, 0.5);
  label.layer.position = center;
  
  // If the label is in center of the circle, it should be selected.
  if (fabs(label.layer.position.x - RADIUS) < 0.01 && fabs(label.layer.position.y - CIRCLE_CENTER_Y) < 0.01) {
    label.textColor = [UIColor colorWithRed:255.0/255.0 green:206.0/255.0 blue:56/255.0 alpha:1.0];    
    
    // Load seriesView.
    for (Category *category in _categories) {
      if ([category.categoryName isEqualToString:label.text]) {
        _seriesView.selectedCategory = category;
      }
    }
    [_seriesView initSeriesView];
    
  } else {
    label.textColor = [UIColor whiteColor];
  }
  
  label.transform = CGAffineTransformMakeRotation(radian);
}


-(void)initLabels
{
  self.viewableLabels = [NSMutableArray array];
  self.labelRadians = [NSMutableArray array];
  for (int i = 0; i < MIN_CATEGORY_SIZE; ++i) {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.numberOfLines = 0;
//    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.userInteractionEnabled = YES;
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateLabel:)];
    tap.maximumNumberOfTouches = 1;
    [label addGestureRecognizer:tap];
    [label setBackgroundColor:[UIColor clearColor]];
    CGFloat currentRadian = initRadian + i * radianStep;
    label.text = [self.categoryNames objectAtIndex:i];
    
    [self updateLabel:label radian:currentRadian];
    
    [self.labelRadians addObject:[NSNumber numberWithFloat:currentRadian]];
    [self.viewableLabels addObject:label];
    [self addSubview:label];
  }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
}

-(void)move:(CGFloat)deltaRadian
{
  for (int i = 0; i < [self.viewableLabels count]; i++) {
    //update radian
    CGFloat currentRadian = [[self.labelRadians objectAtIndex:i] floatValue];
    currentRadian = currentRadian - deltaRadian;
    
    if (currentRadian < 0) {
      currentRadian += 2 * M_PI;
    }
    
    [self.labelRadians replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:currentRadian]];
  }
  
  //update animation
  [UIView beginAnimations:nil context:nil];
  [UIView animateWithDuration:0.3
                   animations:^(void){
                     for (int i = 0; i < [self.viewableLabels count]; i++){
                       UILabel *label = [self.viewableLabels objectAtIndex:i];
                       CGFloat currentRadian = [[self.labelRadians objectAtIndex:i] floatValue];
                       [self updateLabel:label radian:currentRadian];
                     }}
                   completion:^(BOOL finished){
                   }];
  [UIView commitAnimations];
}

- (IBAction)hideFilterViews:(id)sender {
  [_delegate hideFilterViews];
}

- (void)rotateLabel:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        CGPoint tranlation = [panGesture translationInView:self];
        //double len = sqrt(tranlation.x * tranlation.x + tranlation.y * tranlation.y);
        if (tranlation.y > 0) {
            [self move:-radianStep];
        }
        if (tranlation.y < 0) {
            [self move:radianStep];
        }
    }
}

- (void)loadSeriesView:(NSString *)category {
  
}

@end
