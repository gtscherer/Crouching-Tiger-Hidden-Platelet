//
//  Entity.cpp
//  Bubblenauts
//
//  Created by Breton Goers on 11/12/13.
//
//

// The chain goes something like this:
//
//      Object instantiated with a static method. In the static method, we do
//          Object *obj = new Obj() which calls the default initializer
//      Now, we check that the pointer exists, and can call init() on the object
//          like so: if(obj && obj->init()) { }. Here is a full example:
//
//          CCSprite* CCSprite::create()
//          {
//              CCSprite *pSprite = new CCSprite();
//              if (pSprite && pSprite->init())
//              {
//                  pSprite->autorelease();
//                  return pSprite;
//              }
//              CC_SAFE_DELETE(pSprite);
//              return NULL;
//          }
//
//      This returns an autoreleased object that must be retained by the object
//          that created this autoreleased object!
//      Of course, we don't HAVE to do the init() method, but it makes things
//          a little easier for us to debug!

#include "Entity.h"

Entity::Entity()
{
    
}

Entity::~Entity()
{
    
}

uint32_t Entity::getEID()
{
    return m_eID;
}

Entity* Entity::entityWithID(uint32_t eID)
{
    Entity *pEntity = new Entity();
    if (pEntity && pEntity->initWithID(eID)) {
        pEntity->autorelease();
        return pEntity;
    }
    CC_SAFE_DELETE(pEntity);
    return NULL;
}

bool Entity::initWithID(uint32_t eID)
{
    // Here we would initialize anything we needed to.
    m_eID = eID;
    return true;
}











