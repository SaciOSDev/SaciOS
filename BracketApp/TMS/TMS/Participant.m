//
//  Participant.m
//  TMS
//
//  Created by Jeff Morris on 6/2/12.
//  Copyright (c) 2012 SaciOSDev.com. All rights reserved.
//

#import "Participant.h"
#import "Game.h"
#import "Tournament.h"
#import "StockPhoto.h"

@implementation Participant

@dynamic displayName;
@dynamic rank;
@dynamic photo;
@dynamic stockPhoto;
@dynamic tournaments;
@dynamic games;
@dynamic gamesWon;

+ (NSString*)entityName {
    return NSStringFromClass([Participant class]);
}

- (UIImage*)image {
    if ([self stockPhoto]) {
        return [[self stockPhoto] image];
    } else if ([self photo]) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSData *imgData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,[self photo]]];
        if (imgData!=nil) {
            return [UIImage imageWithData:imgData];            
        }
    }
    return nil;
}

- (void)saveImage:(UIImage*)newImage {
    if (newImage) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"YYYYMMDDHHmmss"];
        NSData *imageData = UIImagePNGRepresentation(newImage);
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imgName = [NSString stringWithFormat:@"participant-%@.png",[df stringFromDate:[NSDate date]]];
        [imageData writeToFile:[NSString stringWithFormat:@"%@/%@",path,imgName] atomically:NO];
        [self setPhoto:imgName];
        [self setStockPhoto:nil];
    }
}

- (BOOL)deleteImage {
    NSError *error = nil;
    if ([self photo]) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@",path,[self photo]] error:&error]; 
        if (!error) {
            [self setPhoto:nil];
        }
    }
    [self setStockPhoto:nil];
    return (error) ? NO : YES;
}

@end
