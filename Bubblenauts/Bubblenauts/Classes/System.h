//
//  System.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/12/13.
//
//

#ifndef __Bubblenauts__System__
#define __Bubblenauts__System__

#include <iostream>
#include "cocos2d.h"

class System
{
protected:
    // here we need some refs for some shit that needs to be done
    // this will include an entity manager and
public:
    System() = default;
    
    virtual void update(float dt);
};

#endif /* defined(__Bubblenauts__System__) */
