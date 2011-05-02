#import <Foundation/Foundation.h>
#import "NSObject+Properties.h"

@interface Baz : NSObject {
	NSString* bazData1;
	NSString* bazData2;
	NSString* bazData3;
}
@property(readwrite, nonatomic, retain) NSString *bazData1, *bazData2, *bazData3;
@end

@interface Bar : NSObject {
  Baz* bar;
	NSString* barData;
}
@property(readwrite, nonatomic, retain) Baz *baz;
@property(readwrite, nonatomic, retain) NSString *barData;
@end



@interface Foo : NSObject {
	BOOL aBooleanData;
  NSString* fooData1;
  NSString* fooData2;
  NSString* fooData3;
	Bar* bar;
}

@property(readwrite, nonatomic, retain) NSString *fooData1, *fooData2, *fooData3;
@property(readwrite, nonatomic) BOOL aBooleanData;
@property(readwrite, nonatomic, retain) Bar *bar;
@end
