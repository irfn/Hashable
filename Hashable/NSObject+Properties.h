#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface NSObject(Properties)
-(NSArray*) propertyNames;
-(NSDictionary*) toDictionary:(BOOL) underscoredKeys;
-(NSDictionary*) toDictionary;
-(id) fromDictionary:(NSDictionary*) dictionary;
-(id) fromDictionary:(NSDictionary*) dictionary withKeysUnderscored:(BOOL) underscoredKeys;
@end
