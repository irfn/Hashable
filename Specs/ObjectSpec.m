#import <Cedar/SpecHelper.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import "Factory.h"
#import "NSObject+Properties.h"


SPEC_BEGIN(ObjectSpec)
describe(@"Object toDictionary", ^{
  
  it(@"should translate object properties to key values", ^{
    Foo *foo = [Factory createFoo];
    NSDictionary *properties =  [foo toDictionary];
    

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
    NSDictionary *properties =  [initialFoo toDictionary];
    
    Foo *foo = [[Foo alloc] fromDictionary:properties];
    assertThat(foo.fooData1, equalTo([properties valueForKey:@"fooData1"]));
    assertThat(foo.fooData2, equalTo([properties valueForKey:@"fooData2"]));
    assertThat(foo.fooData3, equalTo([properties valueForKey:@"fooData3"]));
    assertThat(foo.bar.barData, equalTo([[properties valueForKey:@"bar"] valueForKey:@"barData"]));
    assertThat(foo.bar.baz.bazData1, equalTo([[[properties valueForKey:@"bar"] valueForKey:@"baz"] valueForKey:@"bazData1"]));
    assertThat(foo.bar.baz.bazData2, equalTo([[[properties valueForKey:@"bar"] valueForKey:@"baz"] valueForKey:@"bazData2"]));
    assertThat(foo.bar.baz.bazData3, equalTo([[[properties valueForKey:@"bar"] valueForKey:@"baz"] valueForKey:@"bazData3"]));
  });
  
  it(@"should tranlate to underscrored keys", ^{
    Foo *foo = [Factory createFoo];
    NSDictionary *properties =  [foo toDictionary:TRUE];
    assertThat(foo.fooData1, equalTo([properties valueForKey:@"foo_data1"]));        
    assertThat(foo.bar.barData, equalTo([[properties valueForKey:@"bar"] valueForKey:@"bar_data"]));
    assertThat(foo.bar.baz.bazData3, equalTo([[[properties valueForKey:@"bar"] valueForKey:@"baz"] valueForKey:@"baz_data3"]));

  });
	
  it(@"should tranlate dictionary with underscrored keys to object", ^{
    NSDictionary *properties =  [[Factory createFoo] toDictionary:TRUE];
    Foo *foo = [[Foo alloc] fromDictionary:properties withKeysUnderscored:TRUE];
    assertThat(foo.fooData1, equalTo([properties valueForKey:@"foo_data1"]));        
  });
	
  it(@"should tranlate to a dictionary with nested array of objects", ^{
    Foo *foo  = [Factory createFoo]; 
    NSDictionary *properties =  [foo toDictionary:TRUE];
    assertThatBool([[[properties valueForKey:@"bars"] class] isSubclassOfClass:[NSArray class]], equalToBool(YES));
    NSDictionary *barProperties = (NSDictionary *)[((NSArray*) [properties valueForKey:@"bars"] ) objectAtIndex:0];
    
    assertThat(((Bar*)[foo.bars objectAtIndex:0]).barData, equalTo([barProperties valueForKey:@"bar_data"]));        
  });	  

  it(@"should tranlate from a nested array of dictionary", ^{
    NSDictionary *properties =  [ [Factory createFoo] toDictionary:TRUE];
    Foo *foo  = [[Foo alloc] fromDictionary:properties withKeysUnderscored:TRUE];

    NSDictionary *barProperties = (NSDictionary *)[((NSArray*) [properties valueForKey:@"bars"] ) objectAtIndex:0];
    
    assertThat([barProperties valueForKey:@"bar_data"], equalTo(((Bar*)[foo.bars objectAtIndex:0]).barData));        
  });	  

});


SPEC_END