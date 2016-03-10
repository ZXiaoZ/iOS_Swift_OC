//
//  ViewController.m
//  StringEncodeing
//
//  Created by zxz on 16/3/1.
//  Copyright © 2016年 zxz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSInputStream *_stream;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TestPaper" ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile:path]
    ;
    _stream = [NSInputStream inputStreamWithData:data];
    NSStringEncoding encoding = [self _sniffEncoding];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"encoding------%lu",encoding);
    NSLog(@"str------%@",str);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSStringEncoding)_sniffEncoding {
    NSMutableData *_stringBuffer;
    NSStringEncoding encoding = NSUTF8StringEncoding;
    
    uint8_t bytes[512];
    NSInteger readLength = [_stream read:bytes maxLength:512];
    if (readLength > 0 && readLength <= 512) {
        [_stringBuffer appendBytes:bytes length:readLength];
//        [self setTotalBytesRead:[self totalBytesRead] + readLength];
        
        NSInteger bomLength = 0;
        
        if (readLength > 3 && bytes[0] == 0x00 && bytes[1] == 0x00 && bytes[2] == 0xFE && bytes[3] == 0xFF) {
            encoding = NSUTF32BigEndianStringEncoding;
            bomLength = 4;
        } else if (readLength > 3 && bytes[0] == 0xFF && bytes[1] == 0xFE && bytes[2] == 0x00 && bytes[3] == 0x00) {
            encoding = NSUTF32LittleEndianStringEncoding;
            bomLength = 4;
        } else if (readLength > 3 && bytes[0] == 0x1B && bytes[1] == 0x24 && bytes[2] == 0x29 && bytes[3] == 0x43) {
            encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISO_2022_KR);
            bomLength = 4;
        } else if (readLength > 1 && bytes[0] == 0xFE && bytes[1] == 0xFF) {
            encoding = NSUTF16BigEndianStringEncoding;
            bomLength = 2;
        } else if (readLength > 1 && bytes[0] == 0xFF && bytes[1] == 0xFE) {
            encoding = NSUTF16LittleEndianStringEncoding;
            bomLength = 2;
        } else if (readLength > 2 && bytes[0] == 0xEF && bytes[1] == 0xBB && bytes[2] == 0xBF) {
            encoding = NSUTF8StringEncoding;
            bomLength = 3;
        } else {
            NSString *bufferAsUTF8 = nil;
            
            for (NSInteger triedLength = 0; triedLength < 4; ++triedLength) {
                bufferAsUTF8 = [[NSString alloc] initWithBytes:bytes length:readLength-triedLength encoding:NSUTF8StringEncoding];
                if (bufferAsUTF8 != nil) {
                    break;
                }
            }
            
            if (bufferAsUTF8 != nil) {
                encoding = NSUTF8StringEncoding;
            } else {
                NSLog(@"unable to determine stream encoding; assuming MacOSRoman");
                encoding = NSMacOSRomanStringEncoding;
            }
        }
        
        if (bomLength > 0) {
            [_stringBuffer replaceBytesInRange:NSMakeRange(0, bomLength) withBytes:NULL length:0];
        }
    }
    return encoding;
}

@end
