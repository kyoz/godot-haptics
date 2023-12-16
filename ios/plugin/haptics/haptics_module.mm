//
//  haptics_module.m
//  haptics
//
//  Created by Kyoz on 10/07/2023.
//


#ifdef VERSION_4_0
#include "core/config/engine.h"
#else
#include "core/engine.h"
#endif


#include "haptics_module.h"

Haptics * haptics;

void register_haptics_types() {
    haptics = memnew(Haptics);
    Engine::get_singleton()->add_singleton(Engine::Singleton("Haptics", haptics));
};

void unregister_haptics_types() {
    if (haptics) {
        memdelete(haptics);
    }
}
