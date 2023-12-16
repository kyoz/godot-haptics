//
//  haptics.h
//  haptics
//
//  Created by Kyoz on 07/07/2023.
//

#ifndef HAPTICS_H
#define HAPTICS_H

#ifdef VERSION_4_0
#include "core/object/object.h"
#endif

#ifdef VERSION_3_X
#include "core/object.h"
#endif

class Haptics : public Object {

    GDCLASS(Haptics, Object);

    static Haptics *instance;

public:
    void light();
    void medium();
    void heavy();

    static Haptics *get_singleton();
    
    Haptics();
    ~Haptics();

protected:
    static void _bind_methods();
};

#endif
