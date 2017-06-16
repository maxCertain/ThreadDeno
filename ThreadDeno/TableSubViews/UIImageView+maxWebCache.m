//
//  UIImageView+maxWebCache.m
//  ThreadDeno
//
//  Created by liicon on 2017/6/16.
//  Copyright © 2017年 max. All rights reserved.
//

#import "UIImageView+maxWebCache.h"

@implementation UIImageView (maxWebCache)

- (void)max_imageWithUrl:(NSString *)urlString{
    [NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:urlString];
}

- (void)downloadImage:(NSString *)urlStr{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        [self performSelectorOnMainThread:@selector(upImageUI:) withObject:image waitUntilDone:NO];
    }
}

- (void)upImageUI:(UIImage *)image{
    
    self.image = image;
}

@end
