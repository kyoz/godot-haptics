//
//  haptics.m
//  haptics
//
//  Created by Kyoz on 07/07/2023.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#ifdef VERSION_4_0
#include "core/object/class_db.h"
#else
#include "core/class_db.h"
#endif

#include "haptics.h"

Haptics *Haptics::instance = NULL;

Haptics::Haptics() {
    instance = this;
    NSLog(@"initialize haptics");
}

Haptics::~Haptics() {
    if (instance == this) {
        instance = NULL;
    }
    NSLog(@"deinitialize haptics");
}

Haptics *Haptics::get_singleton() {
    return instance;
};


void Haptics::_bind_methods() {    
    ClassDB::bind_method("light", &Haptics::light);
    ClassDB::bind_method("medium", &Haptics::medium);
    ClassDB::bind_method("heavy", &Haptics::heavy);
}

void Haptics::light() {
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [generator prepare];
    [generator impactOccurred];
}

void Haptics::medium() {
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    [generator prepare];
    [generator impactOccurred];
}

void Haptics::heavy() {
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
    [generator prepare];
    [generator impactOccurred];
}
