//
//  Entity.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/12/13.
//
//

#ifndef __Bubblenauts__Entity__
#define __Bubblenauts__Entity__

#include <iostream>
#include "cocos2d.h"

USING_NS_CC;

class Entity : public CCObject
{
public:
    Entity();
    virtual ~Entity();
    
    static Entity* entityWithID(uint32_t eID);
    
private:
    uint32_t m_eID;
    
    bool initWithID(uint32_t eID);
};

#endif /* defined(__Bubblenauts__Entity__) */
