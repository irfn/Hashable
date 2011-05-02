#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface NSObject(Properties)
-(NSArray*) propertyNames;
-(NSDictionary*) toDictionary;
-(id) fromDictionary:(NSDictionary*) dictionary;
@end
