//
//  EntityManager.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/12/13.
//
//

#ifndef __Bubblenauts__EntityManager__
#define __Bubblenauts__EntityManager__

#include <iostream>
#include <string>
#include "cocos2d.h"

class Entity;
class Component;

USING_NS_CC;

class EntityManager : public CCObject
{
public:
    EntityManager();
    ~EntityManager();
    
    static EntityManager* entityManager(void);
    Entity* createEntity(void);
    
    void addComponentWithNameToEntity(Component*, std::string, Entity*);
    Component* getComponentTypeFromEntity(std::string, Entity*);
private:
    uint32_t generateNewEID();
    
    CCArray         *m_pEntities;
    CCDictionary    *m_pComponentsByClass;
    uint32_t        m_lowestEID;
};

#endif /* defined(__Bubblenauts__EntityManager__) */
