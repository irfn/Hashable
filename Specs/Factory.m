#import "Factory.h"

@implementation Factory
+ (Foo*) createFoo {
    Baz *baz = [[Baz alloc] init];
    baz.bazData1 = @"data 1";
    baz.bazData2 = @"data 2";
    baz.bazData3 = @"data 3";
    
    Bar *bar = [[Bar alloc] init] ;
    bar.barData = @"some Data";
    bar.baz= baz;
    
    Foo *foo =[[Foo alloc] init];
    foo.aBooleanData = YES;
    foo.fooData1 = @"a foo data 1";
    foo.fooData2 = @"a foo data 2";
    foo.fooData3 = @"a foo data 3";
    foo.bar = bar;	
    return foo;
}
@end
