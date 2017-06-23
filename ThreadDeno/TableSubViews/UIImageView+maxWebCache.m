//
//  UIImageView+maxWebCache.m
//  ThreadDeno
//
//  Created by liicon on 2017/6/16.
//  Copyright © 2017年 max. All rights reserved.
//

#import "UIImageView+maxWebCache.h"



@implementation UIImageView (maxWebCache)

- (void)max_imageWithUrl:(NSString *)urlString placeholderImage:(UIImage *)placeholder{
    [self max_imageWithUrl:urlString];
    if (placeholder) {
        self.image = placeholder;
    }
}

- (void)max_imageWithUrl:(NSString *)urlString{
    [NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:urlString];
}

- (void)downloadImage:(NSString *)urlStr{
    
    dispatch_queue_t aqueue = dispatch_queue_create("com.image.load", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(aqueue, ^{
        NSURL *url = [NSURL URLWithString:urlStr];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        [self performSelectorOnMainThread:@selector(upImageUI:) withObject:image waitUntilDone:NO];
    });
}

- (void)upImageUI:(UIImage *)image{
    self.image = image;
}

@end
