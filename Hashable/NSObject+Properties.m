#import "NSObject+Properties.h"


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

-(NSDictionary*) toDictionary{
	NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
	for (NSString *key in  [self propertyNames]) {
		id valueForKey = [self valueForKey:key];
		if([[valueForKey propertyNames] count] > 0)
			[properties setValue:[valueForKey toDictionary] forKey:key];
		else
			[properties setValue:valueForKey forKey:key];
	}
	return properties;
}
- (Class) getPropertyClass:(NSString*) key {
	objc_property_t property = class_getProperty([self class], [key UTF8String] );
	return NSClassFromString([[[NSString stringWithUTF8String:property_getAttributes(property)] componentsSeparatedByString:@"\""] objectAtIndex:1]);
}

-(id) fromDictionary:(NSDictionary*) properties{
	for (NSString *key in  [self propertyNames]) {
		id valueForKey = [properties valueForKey:key];
		if([[valueForKey class]  isSubclassOfClass:[NSDictionary class]]){
			[self setValue: [[[self getPropertyClass:key] alloc] fromDictionary:valueForKey] forKey:key ];
		}
		else
		{
			[self setValue:valueForKey forKey:key];
		}								
	}
	return self;	
}

@end
