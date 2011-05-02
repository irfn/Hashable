#import "NSString+Conversions.h"
#import "RegexKitLite.h"

@implementation NSString(Conversions)

- (NSString *)asCamelCase {
  NSArray *tokens = [self componentsSeparatedByRegex:@"_"];
  NSMutableArray *convertedTokens = [[NSMutableArray alloc] init];
  [convertedTokens addObject:[tokens objectAtIndex:0]];
  
  for(int i=1;i<[tokens count]; i++)
  {
    NSString *current =(NSString *) [tokens objectAtIndex:i];
    [convertedTokens addObject:[current stringByReplacingCharactersInRange:
                                NSMakeRange(0, 1) withString:[[current substringToIndex:1] uppercaseString]]]; 
  }
  return [convertedTokens componentsJoinedByString:@""];
}
- (NSString *)asUnderscored {
  return [[self stringByReplacingOccurrencesOfRegex:@"([a-z\\d])([A-Z])" withString:@"$1_$2"] lowercaseString];
}

@end
