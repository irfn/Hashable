#import <Cedar/SpecHelper.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "NSString+Conversions.h"


SPEC_BEGIN(NSStringSpec)
describe(@"String Conversions", ^{
  
  it(@"should convert underscored to camelcase", ^{
    assertThat([@"foo_bar_baz" asCamelCase], equalTo(@"fooBarBaz"));
  });

  it(@"should convert camelcase to underscored", ^{
    assertThat([@"fooBarBaz" asUnderscored], equalTo(@"foo_bar_baz"));
  });

});


SPEC_END