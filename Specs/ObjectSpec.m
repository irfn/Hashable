#import <Cedar/SpecHelper.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import "Factory.h"
#import "NSObject+Properties.h"


SPEC_BEGIN(ObjectSpec)
describe(@"Object toDictionary", ^{
  
  it(@"should translate object properties to key values", ^{
    Foo *foo = [Factory createFoo];
    NSDictionary *properties =  [foo propertiesDictionary];
    assertThat([properties valueForKey:@"fooData1"], equalTo(foo.fooData1));
    assertThat([properties valueForKey:@"fooData2"], equalTo(foo.fooData2));
    assertThat([properties valueForKey:@"fooData3"], equalTo(foo.fooData3));
    assertThat([[properties valueForKey:@"bar"] valueForKey:@"barData"], equalTo(foo.bar.barData));
    assertThat([[[properties valueForKey:@"bar"] valueForKey:@"baz"] valueForKey:@"bazData1"], equalTo(foo.bar.baz.bazData1));
    assertThat([[[properties valueForKey:@"bar"] valueForKey:@"baz"] valueForKey:@"bazData2"], equalTo(foo.bar.baz.bazData2));
    assertThat([[[properties valueForKey:@"bar"] valueForKey:@"baz"] valueForKey:@"bazData3"], equalTo(foo.bar.baz.bazData3));
  });
	
  it(@"should translate key values to object", ^{
    Foo *initialFoo = [Factory createFoo];
    NSDictionary *properties =  [initialFoo propertiesDictionary];
    
    Foo *foo = [[Foo alloc] fromDictionary:properties];
    assertThat(foo.fooData1, equalTo([properties valueForKey:@"fooData1"]));
    assertThat(foo.fooData2, equalTo([properties valueForKey:@"fooData2"]));
    assertThat(foo.fooData3, equalTo([properties valueForKey:@"fooData3"]));
    assertThat(foo.bar.barData, equalTo([[properties valueForKey:@"bar"] valueForKey:@"barData"]));
    assertThat(foo.bar.baz.bazData1, equalTo([[[properties valueForKey:@"bar"] valueForKey:@"baz"] valueForKey:@"bazData1"]));
    assertThat(foo.bar.baz.bazData2, equalTo([[[properties valueForKey:@"bar"] valueForKey:@"baz"] valueForKey:@"bazData2"]));
    assertThat(foo.bar.baz.bazData3, equalTo([[[properties valueForKey:@"bar"] valueForKey:@"baz"] valueForKey:@"bazData3"]));
  });
	

});


SPEC_END