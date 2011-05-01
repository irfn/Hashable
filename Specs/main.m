#import <Foundation/Foundation.h>                                                                                                                                                                                                                                          
#import <Cedar/Cedar.h>                                                                                                                

int main (int argc, const char *argv[]) {
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int status = runAllSpecs();
  [pool release];
  
  return status;
}        
