#import "NSObject+Properties.h"
#import "NSString+Inflections.h"

@implementation NSObject(Properties)

-(NSArray*) propertyNames{
	NSMutableArray *propertyKeys = [[[NSMutableArray alloc] init] autorelease];
	unsigned int outCount, i;
	objc_property_t *properties = class_copyPropertyList([self class], &outCount);
	for(i = 0; i < outCount; i++) {
		[propertyKeys addObject:[NSString stringWithFormat:@"%s", property_getName(properties[i])]];
	}
	free(properties);
	return propertyKeys;
}

-(NSDictionary*) toDictionary:(BOOL) underscoredKeys{
	NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
	for (NSString *key in  [self propertyNames]) {
		id valueForKey = [self valueForKey:key];
    NSString *dictionaryKey = underscoredKeys ? [key underscore] : key;
    if([valueForKey isKindOfClass:[NSArray class]]){
      NSArray *nestedElements = (NSArray *) valueForKey;
      NSMutableArray *convertedArray = [[NSMutableArray alloc] init];
      for (id element in nestedElements) {
        [convertedArray addObject:[element toDictionary:underscoredKeys ]];
      }
      [properties setValue:convertedArray forKey:dictionaryKey];      
    }      
    else if([[valueForKey propertyNames] count] > 0)
			[properties setValue:[valueForKey toDictionary:underscoredKeys] forKey:dictionaryKey];      
		else
			[properties setValue:valueForKey forKey:dictionaryKey];
	}
	return properties;
}

-(NSDictionary*) toDictionary{
  return [self toDictionary:FALSE];
}

- (Class) getPropertyClass:(NSString*) key {
	objc_property_t property = class_getProperty([self class], [key UTF8String] );
	return NSClassFromString([[[NSString stringWithUTF8String:property_getAttributes(property)] componentsSeparatedByString:@"\""] objectAtIndex:1]);
}

-(id) fromDictionary:(NSDictionary *)properties withKeysUnderscored:(BOOL)underscoredKeys{
  for (NSString *key in  [self propertyNames]) {
    NSString *propertyKey = underscoredKeys ? [key underscore] : key;
		id valueForKey = [properties valueForKey:propertyKey];
    
    if([valueForKey isKindOfClass:[NSArray class]]){
      NSArray *nestedElements = (NSArray *) valueForKey;
      NSMutableArray *convertedArray = [[NSMutableArray alloc] init];
      for (id element in nestedElements) {
        id objectFromDictionary = [[NSClassFromString([[key singularize] classify]) alloc] fromDictionary:element withKeysUnderscored:underscoredKeys];
        [convertedArray addObject: objectFromDictionary];
      }
      [self setValue:convertedArray forKey:key];
    }
		else if([[valueForKey class]  isSubclassOfClass:[NSDictionary class]]){
			[self setValue: [[[self getPropertyClass:key] alloc] fromDictionary:valueForKey withKeysUnderscored:underscoredKeys] forKey:key ];
		}
		else      
		{
			[self setValue:valueForKey forKey:key];
		}								
	}
	return self;	
}

-(id) fromDictionary:(NSDictionary*) properties{
	return [self fromDictionary:properties withKeysUnderscored:FALSE];
}

@end
