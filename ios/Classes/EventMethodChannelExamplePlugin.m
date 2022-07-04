#import "EventMethodChannelExamplePlugin.h"
#if __has_include(<event_method_channel_example/event_method_channel_example-Swift.h>)
#import <event_method_channel_example/event_method_channel_example-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "event_method_channel_example-Swift.h"
#endif

@implementation EventMethodChannelExamplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEventMethodChannelExamplePlugin registerWithRegistrar:registrar];
}
@end
